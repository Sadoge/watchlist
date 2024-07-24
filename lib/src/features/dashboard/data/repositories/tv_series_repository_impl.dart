import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/exceptions.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/shared/data/datasources/hive_data_source.dart';
import 'package:watchlist/src/features/shared/data/datasources/tmdb_data_source.dart';
import 'package:watchlist/src/features/shared/data/models/tv_series_model.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';
import 'package:watchlist/src/features/dashboard/domain/repositories/tv_series_repository.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final TMDBDataSource tmdbDataSource;
  final HiveDataSource hiveDataSource;

  TVSeriesRepositoryImpl({
    required this.tmdbDataSource,
    required this.hiveDataSource,
  });

  @override
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query) async {
    try {
      final tvSeriesModels = await tmdbDataSource.fetchTVSeries(query);
      final tvSeries = tvSeriesModels
          .map((model) => TVSeries(
                id: model.id,
                name: model.name,
                overview: model.overview,
                posterPath: model.posterPath ?? '',
                voteAverage: model.voteAverage,
                status: model.status ?? '',
                lastEpisode: model.lastEpisode ?? '',
              ))
          .toList();
      return Right(tvSeries);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Option<Failure>> addTVSeries(TVSeries tvSeries) async {
    try {
      final tvSeriesModel = TVSeriesModel(
        id: tvSeries.id,
        name: tvSeries.name,
        overview: tvSeries.overview,
        posterPath: tvSeries.posterPath,
        voteAverage: tvSeries.voteAverage,
        status: tvSeries.status,
        lastEpisode: tvSeries.lastEpisode,
      );
      await hiveDataSource.addTVSeries(tvSeriesModel);
      return none();
    } on CacheException {
      return some(CacheFailure());
    } catch (e) {
      return some(CacheFailure());
    }
  }

  @override
  Future<Option<Failure>> removeTVSeries(int id) async {
    try {
      await hiveDataSource.removeTVSeries(id);
      return none();
    } on CacheException {
      return some(CacheFailure());
    } catch (e) {
      return some(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getSavedTVSeries() async {
    try {
      final tvSeriesModels = await hiveDataSource.getTVSeries();
      final tvSeries = tvSeriesModels
          .map((model) => TVSeries(
                id: model.id,
                name: model.name,
                overview: model.overview,
                posterPath: model.posterPath ?? '',
                voteAverage: model.voteAverage,
                status: model.status ?? 'Want to Watch',
                lastEpisode: model.lastEpisode ?? '',
              ))
          .toList();
      return Right(tvSeries);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Option<Failure>> updateTVSeries(TVSeries tvSeries) async {
    try {
      final tvSeriesModel = TVSeriesModel(
        id: tvSeries.id,
        name: tvSeries.name,
        overview: tvSeries.overview,
        posterPath: tvSeries.posterPath,
        voteAverage: tvSeries.voteAverage,
        status: tvSeries.status,
        lastEpisode: tvSeries.lastEpisode,
      );
      await hiveDataSource.addTVSeries(tvSeriesModel);
      return none();
    } on CacheException {
      return some(CacheFailure());
    } catch (e) {
      return some(CacheFailure());
    }
  }
}
