import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/tv_series/domain/entities/season_detail.dart';

abstract class SeasonRepository {
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
      int seriesId, int seasonNumber);
}
