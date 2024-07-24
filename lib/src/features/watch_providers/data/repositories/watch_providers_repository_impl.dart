import 'package:dartz/dartz.dart';
import 'package:watchlist/src/core/error/exceptions.dart';
import 'package:watchlist/src/core/error/failures.dart';
import 'package:watchlist/src/features/shared/data/datasources/tmdb_data_source.dart';
import 'package:watchlist/src/features/watch_providers/domain/entities/watch_provider.dart';
import 'package:watchlist/src/features/watch_providers/domain/repositories/watch_provider_repository.dart';

class WatchProvidersRepositoryImpl implements WatchProvidersRepository {
  final TMDBDataSource tmdbDataSource;

  WatchProvidersRepositoryImpl({required this.tmdbDataSource});

  @override
  Future<Either<Failure, List<WatchProvider>>> getWatchProviders(int id) async {
    try {
      final providers = await tmdbDataSource.fetchWatchProviders(id);
      return Right(providers);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
