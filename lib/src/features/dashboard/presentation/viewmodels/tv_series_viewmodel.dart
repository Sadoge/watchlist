import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';
import 'package:watchlist/src/features/dashboard/domain/repositories/tv_series_repository.dart';

class TVSeriesViewModel extends StateNotifier<AsyncValue<List<TVSeries>>> {
  final TVSeriesRepository repository;

  TVSeriesViewModel(this.repository) : super(const AsyncValue.loading());

  Future<void> searchTVSeries(String query) async {
    state = const AsyncValue.loading();
    final result = await repository.searchTVSeries(query);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (tvSeries) => state = AsyncValue.data(tvSeries),
    );
  }
}
