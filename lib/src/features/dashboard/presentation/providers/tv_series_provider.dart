import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';
import 'package:watchlist/src/features/dashboard/presentation/viewmodels/tv_series_viewmodel.dart';
import 'package:watchlist/src/features/shared/providers/tv_series_repository_provider.dart';

final tvSeriesNotifierProvider =
    StateNotifierProvider<TVSeriesViewModel, AsyncValue<List<TVSeries>>>(
  (ref) => TVSeriesViewModel(ref.read(tvSeriesRepositoryProvider)),
);
