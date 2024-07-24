import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/dashboard/data/repositories/tv_series_detail_repository_impl.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series_detail.dart';
import 'package:watchlist/src/features/dashboard/presentation/viewmodels/tv_series_detail_viewmodel.dart';
import 'package:watchlist/src/features/shared/providers/datasource_providers.dart';

final tvSeriesDetailRepositoryProvider = Provider(
  (ref) => TVSeriesDetailRepositoryImpl(
    tmdbDataSource: ref.read(tmdbDataSourceProvider),
  ),
);

final tvSeriesDetailNotifierProvider = StateNotifierProvider.family<
    TVSeriesDetailViewModel, AsyncValue<TVSeriesDetail>, int>(
  (ref, id) {
    final vm =
        TVSeriesDetailViewModel(ref.read(tvSeriesDetailRepositoryProvider));
    vm.fetchTVSeriesDetail(id);
    return vm;
  },
);
