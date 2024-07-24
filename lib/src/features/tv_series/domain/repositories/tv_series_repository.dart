import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/tv_series/data/models/season_detail_model.dart';
import 'package:watchlist/src/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:watchlist/src/features/tv_series/data/models/watch_provider_model.dart';
import 'package:watchlist/src/features/tv_series/domain/entities/tv_series.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
  Future<Option<Failure>> addTVSeries(TVSeries tvSeries);
  Future<Option<Failure>> removeTVSeries(int id);
  Future<Either<Failure, List<TVSeries>>> getSavedTVSeries();
  Future<Option<Failure>> updateTVSeries(TVSeries tvSeries);
  Future<Either<Failure, TVSeriesDetailModel>> getTVSeriesDetail(int id);
  Future<Either<Failure, SeasonDetailModel>> getSeasonDetail(
      int seriesId, int seasonNumber);
  Future<Either<Failure, List<WatchProviderModel>>> getWatchProviders(int id);
}
