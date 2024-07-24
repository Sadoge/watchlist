import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/tv_series/domain/entities/watch_provider.dart';
import 'package:watchlist/src/features/tv_series/domain/repositories/watch_provider_repository.dart';

class WatchProvidersViewModel
    extends StateNotifier<AsyncValue<List<WatchProvider>>> {
  final WatchProvidersRepository repository;

  WatchProvidersViewModel(this.repository) : super(const AsyncValue.loading());

  Future<void> fetchWatchProviders(int seriesId) async {
    state = const AsyncValue.loading();
    final result = await repository.getWatchProviders(seriesId);
    result.fold(
      (failure) => state =
          AsyncValue.error(_mapFailureToMessage(failure), StackTrace.current),
      (providers) => state = AsyncValue.data(providers),
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
