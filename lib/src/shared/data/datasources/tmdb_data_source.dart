import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchlist/src/features/tv_series/data/models/season_detail_model.dart';
import 'package:watchlist/src/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:watchlist/src/shared/data/models/tv_series_model.dart';
import 'package:watchlist/src/features/tv_series/data/models/watch_provider_model.dart';

class TMDBDataSource {
  final http.Client client;
  final String apiKey;

  TMDBDataSource(this.client, this.apiKey);

  Future<List<TVSeriesModel>> fetchTVSeries(String query) async {
    final response = await client.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/tv?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      return results.map((json) => TVSeriesModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch TV series');
    }
  }

  Future<TVSeriesDetailModel> fetchTVSeriesDetail(int id) async {
    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/tv/$id?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return TVSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch TV series details');
    }
  }

  Future<SeasonDetailModel> fetchSeasonDetail(
      int seriesId, int seasonNumber) async {
    final response = await client.get(
      Uri.parse(
          'https://api.themoviedb.org/3/tv/$seriesId/season/$seasonNumber?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return SeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch season details');
    }
  }

  Future<List<WatchProviderModel>> fetchWatchProviders(int id) async {
    final response = await client.get(
      Uri.parse(
          'https://api.themoviedb.org/3/tv/$id/watch/providers?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final providers =
          json.decode(response.body)['results']['PH']['flatrate'] as List;
      return providers
          .map((json) => WatchProviderModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch watch providers');
    }
  }
}
