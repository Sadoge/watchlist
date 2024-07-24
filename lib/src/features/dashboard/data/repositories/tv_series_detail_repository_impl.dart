import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/exceptions.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/shared/data/datasources/tmdb_data_source.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series_detail.dart';
import 'package:watchlist/src/features/dashboard/domain/repositories/tv_series_detail_repository.dart';

class TVSeriesDetailRepositoryImpl implements TVSeriesDetailRepository {
  final TMDBDataSource tmdbDataSource;

  TVSeriesDetailRepositoryImpl({required this.tmdbDataSource});

  @override
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id) async {
    try {
      final tvSeriesDetail = await tmdbDataSource.fetchTVSeriesDetail(id);
      return Right(tvSeriesDetail);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
