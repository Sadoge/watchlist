import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/season/data/repositories/season_repository_impl.dart';
import 'package:watchlist/src/features/season/domain/entities/season_detail.dart';
import 'package:watchlist/src/features/season/presentation/viewmodels/season_detail_viewmodel.dart';
import 'package:watchlist/src/providers.dart';

final seasonRepositoryProvider = Provider(
  (ref) => SeasonRepositoryImpl(
    tmdbDataSource: ref.read(tmdbDataSourceProvider),
  ),
);

final seasonDetailNotifierProvider = StateNotifierProvider.family<
    SeasonDetailViewModel, AsyncValue<SeasonDetail>, Tuple2<int, int>>(
  (ref, params) {
    final vm = SeasonDetailViewModel(ref.read(seasonRepositoryProvider));
    vm.fetchSeasonDetail(params.value1, params.value2);
    return vm;
  },
);
