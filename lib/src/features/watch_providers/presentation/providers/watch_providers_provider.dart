import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/watch_providers/data/repositories/watch_providers_repository_impl.dart';
import 'package:watchlist/src/features/watch_providers/domain/entities/watch_provider.dart';
import 'package:watchlist/src/features/watch_providers/presentation/viewmodels/watch_provider_viewmodel.dart';
import 'package:watchlist/src/features/shared/providers/datasource_providers.dart';

final watchProvidersRepositoryProvider = Provider(
  (ref) => WatchProvidersRepositoryImpl(
    tmdbDataSource: ref.read(tmdbDataSourceProvider),
  ),
);

final watchProvidersNotifierProvider = StateNotifierProvider.family<
    WatchProvidersViewModel, AsyncValue<List<WatchProvider>>, int>(
  (ref, id) {
    final vm =
        WatchProvidersViewModel(ref.read(watchProvidersRepositoryProvider));

    vm.fetchWatchProviders(id);

    return vm;
  },
);
