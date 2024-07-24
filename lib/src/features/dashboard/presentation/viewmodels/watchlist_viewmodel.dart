import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';
import 'package:watchlist/src/features/dashboard/domain/repositories/tv_series_repository.dart';

class WatchlistViewModel extends StateNotifier<AsyncValue<List<TVSeries>>> {
  final TVSeriesRepository repository;
  final Set<int> _savedSeriesIds = {};

  WatchlistViewModel(this.repository) : super(const AsyncValue.loading()) {
    loadSavedTVSeries();
  }

  Future<void> loadSavedTVSeries({String? status, String? title}) async {
    state = const AsyncValue.loading();
    final result = await repository.getSavedTVSeries();
    result.fold(
      (failure) => state =
          AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (tvSeriesList) {
        if (status != null && status.isNotEmpty) {
          tvSeriesList.removeWhere(
              (series) => series.status.toLowerCase() != status.toLowerCase());
        } else if (title != null && title.isNotEmpty) {
          tvSeriesList.removeWhere((series) =>
              !series.name.toLowerCase().contains(title.toLowerCase()));
        }

        _savedSeriesIds.addAll(tvSeriesList.map((series) => series.id));
        state = AsyncValue.data(tvSeriesList);
      },
    );
  }

  Future<void> addTVSeries(TVSeries tvSeries) async {
    if (_savedSeriesIds.contains(tvSeries.id)) return;

    final result = await repository.addTVSeries(tvSeries);
    result.fold(
      () {
        _savedSeriesIds.add(tvSeries.id);
        state = AsyncValue.data([...state.value!, tvSeries]);
      },
      (failure) => state =
          AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
    );
  }

  Future<void> removeTVSeries(int id) async {
    final result = await repository.removeTVSeries(id);
    result.fold(
      () {
        _savedSeriesIds.remove(id);
        state = AsyncValue.data(
            state.value!.where((series) => series.id != id).toList());
      },
      (failure) => state =
          AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
    );
  }

  Future<void> updateTVSeries(TVSeries updatedSeries) async {
    final result = await repository.updateTVSeries(updatedSeries);
    result.fold(
      () {
        final updatedList = state.value!.map((series) {
          return series.id == updatedSeries.id ? updatedSeries : series;
        }).toList();
        state = AsyncValue.data(updatedList);
      },
      (failure) => state =
          AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
    );
  }

  Future<void> exportWatchlist() async {
    try {
      final result = await repository.getSavedTVSeries();
      result.fold(
        (failure) {
          state = AsyncValue.error(
              _mapFailureToMessage(failure), StackTrace.current);
        },
        (tvSeriesList) async {
          final jsonString = jsonEncode(
              tvSeriesList.map((series) => series.toJson()).toList());

          if (kIsWeb) {
            final bytes = utf8.encode(jsonString);
            final blob = html.Blob([bytes]);
            final url = html.Url.createObjectUrlFromBlob(blob);
            final _ = html.AnchorElement(href: url)
              ..setAttribute("download", "watchlist.json")
              ..click();
            html.Url.revokeObjectUrl(url);
          } else {
            final directory = await getApplicationDocumentsDirectory();
            final file = io.File('${directory.path}/watchlist.json');
            await file.writeAsString(jsonString);
          }

          state = AsyncValue.data(tvSeriesList);
        },
      );
    } catch (e) {
      state =
          AsyncValue.error('Failed to export watchlist', StackTrace.current);
    }
  }

  Future<void> importWatchlist() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.single.bytes;
        String jsonString;

        if (kIsWeb) {
          jsonString = utf8.decode(fileBytes!);
        } else {
          final file = io.File(result.files.single.path!);
          jsonString = await file.readAsString();
        }

        final List<dynamic> jsonData = jsonDecode(jsonString);
        final importedSeries =
            jsonData.map((item) => TVSeries.fromJson(item)).toList();

        // Clear existing data and insert imported data
        for (var series in importedSeries) {
          await repository.addTVSeries(series);
        }

        _savedSeriesIds.addAll(importedSeries.map((series) => series.id));
        state = AsyncValue.data(importedSeries);
      }
    } catch (e) {
      state =
          AsyncValue.error('Failed to import watchlist', StackTrace.current);
    }
  }

  bool isSeriesSaved(int id) => _savedSeriesIds.contains(id);

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (CacheFailure):
        return 'Cache Failure: Unable to fetch data from the local cache.';
      default:
        return 'Unexpected Error';
    }
  }
}
