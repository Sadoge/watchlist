import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series_detail.dart';

abstract class TVSeriesDetailRepository {
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
}
