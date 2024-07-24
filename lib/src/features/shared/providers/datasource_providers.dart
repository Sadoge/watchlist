import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:watchlist/src/features/shared/data/datasources/hive_data_source.dart';
import 'package:watchlist/src/features/shared/data/datasources/tmdb_data_source.dart';
import 'package:watchlist/src/features/shared/data/models/tv_series_model.dart';
import 'package:http/http.dart' as http;

final httpProvider = Provider((ref) => http.Client());
final tmdbDataSourceProvider = Provider((ref) =>
    TMDBDataSource(ref.read(httpProvider), 'd57b258511eadb6e87fd312cefa6fa96'));
final hiveDataSourceProvider =
    Provider((ref) => HiveDataSource(Hive.box<TVSeriesModel>('tvSeriesBox')));
