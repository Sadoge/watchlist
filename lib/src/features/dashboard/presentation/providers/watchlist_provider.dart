import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';
import 'package:watchlist/src/features/dashboard/presentation/viewmodels/watchlist_viewmodel.dart';
import 'package:watchlist/src/features/shared/providers/tv_series_repository_provider.dart';

final watchlistNotifierProvider =
    StateNotifierProvider<WatchlistViewModel, AsyncValue<List<TVSeries>>>(
  (ref) => WatchlistViewModel(ref.read(tvSeriesRepositoryProvider)),
);
