import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/tv_series/domain/entities/tv_series.dart';
import 'package:watchlist/src/features/tv_series/presentation/viewmodels/tv_series_viewmodel.dart';
import 'package:watchlist/src/providers.dart';

final tvSeriesNotifierProvider =
    StateNotifierProvider<TVSeriesViewModel, AsyncValue<List<TVSeries>>>(
  (ref) => TVSeriesViewModel(ref.read(tvSeriesRepositoryProvider)),
);
