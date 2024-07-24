import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/exceptions.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/season/domain/entities/season_detail.dart';
import 'package:watchlist/src/features/season/domain/repositories/series_detail_repository.dart';
import 'package:watchlist/src/features/shared/data/datasources/tmdb_data_source.dart';

class SeasonRepositoryImpl implements SeasonRepository {
  final TMDBDataSource tmdbDataSource;

  SeasonRepositoryImpl({required this.tmdbDataSource});

  @override
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
      int seriesId, int seasonNumber) async {
    try {
      final seasonDetail =
          await tmdbDataSource.fetchSeasonDetail(seriesId, seasonNumber);
      return Right(seasonDetail);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
