import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/tv_series/data/models/season_detail_model.dart';
import 'package:watchlist/src/features/tv_series/domain/repositories/tv_series_repository.dart';

class SeasonDetailViewModel
    extends StateNotifier<AsyncValue<SeasonDetailModel>> {
  final TVSeriesRepository repository;

  SeasonDetailViewModel(this.repository) : super(const AsyncValue.loading());

  Future<void> fetchSeasonDetail(int seriesId, int seasonNumber) async {
    state = const AsyncValue.loading();
    final result = await repository.getSeasonDetail(seriesId, seasonNumber);
    result.fold(
      (failure) => state =
          AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (seasonDetail) => state = AsyncValue.data(seasonDetail),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure: Unable to fetch data from the server.';
      default:
        return 'Unexpected Error';
    }
  }
}
