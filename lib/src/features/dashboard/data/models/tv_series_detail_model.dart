import 'package:watchlist/src/features/dashboard/data/models/season_model.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series_detail.dart';

class TVSeriesDetailModel extends TVSeriesDetail {
  TVSeriesDetailModel({
    required super.id,
    required super.name,
    required super.overview,
    required super.posterPath,
    required super.voteAverage,
    required super.genres,
    required super.firstAirDate,
    required super.lastAirDate,
    required super.numberOfSeasons,
    required super.numberOfEpisodes,
    required super.seasons,
  });

  factory TVSeriesDetailModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesDetailModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      voteAverage: json['vote_average'].toDouble(),
      genres: (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList(),
      firstAirDate: json['first_air_date'] ?? '',
      lastAirDate: json['last_air_date'] ?? '',
      numberOfSeasons: json['number_of_seasons'],
      numberOfEpisodes: json['number_of_episodes'],
      seasons: (json['seasons'] as List)
          .map((season) => SeasonModel.fromJson(season))
          .toList(),
    );
  }
}
