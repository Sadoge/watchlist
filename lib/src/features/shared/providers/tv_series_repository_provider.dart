import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/dashboard/data/repositories/tv_series_repository_impl.dart';
import 'package:watchlist/src/features/shared/providers/datasource_providers.dart';

final tvSeriesRepositoryProvider = Provider(
  (ref) => TVSeriesRepositoryImpl(
    tmdbDataSource: ref.read(tmdbDataSourceProvider),
    hiveDataSource: ref.read(hiveDataSourceProvider),
  ),
);
