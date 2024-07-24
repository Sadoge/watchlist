import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
  Future<Option<Failure>> addTVSeries(TVSeries tvSeries);
  Future<Option<Failure>> removeTVSeries(int id);
  Future<Either<Failure, List<TVSeries>>> getSavedTVSeries();
  Future<Option<Failure>> updateTVSeries(TVSeries tvSeries);
}
