import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/watch_providers/domain/entities/watch_provider.dart';

abstract class WatchProvidersRepository {
  Future<Either<Failure, List<WatchProvider>>> getWatchProviders(int id);
}
