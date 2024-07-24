import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/tv_series/domain/entities/season_detail.dart';
import 'package:watchlist/src/features/tv_series/presentation/viewmodels/season_detail_viewmodel.dart';
import 'package:watchlist/src/providers.dart';

final seasonDetailNotifierProvider = StateNotifierProvider.family<
    SeasonDetailViewModel, AsyncValue<SeasonDetail>, Tuple2<int, int>>(
  (ref, params) {
    final vm = SeasonDetailViewModel(ref.read(tvSeriesRepositoryProvider));
    vm.fetchSeasonDetail(params.value1, params.value2);
    return vm;
  },
);
