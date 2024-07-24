import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series_detail.dart';
import 'package:watchlist/src/features/dashboard/domain/repositories/tv_series_detail_repository.dart';

class TVSeriesDetailViewModel
    extends StateNotifier<AsyncValue<TVSeriesDetail>> {
  final TVSeriesDetailRepository repository;

  TVSeriesDetailViewModel(this.repository) : super(const AsyncValue.loading());

  Future<void> fetchTVSeriesDetail(int id) async {
    state = const AsyncValue.loading();
    final result = await repository.getTVSeriesDetail(id);

    result.fold(
      (failure) => state =
          AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (tvSeriesDetail) => state = AsyncValue.data(tvSeriesDetail),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure: Unable to fetch data from the server.';
      default:
        return 'Unexpected Error';
    }
  }
}
