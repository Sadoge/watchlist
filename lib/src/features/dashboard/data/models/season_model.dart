import 'package:watchlist/src/features/dashboard/domain/entities/season.dart';

class SeasonModel extends Season {
  SeasonModel({
    required super.id,
    required super.name,
    required super.overview,
    required super.posterPath,
    required super.seasonNumber,
    required super.episodeCount,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json['id'],
        name: json['name'],
        overview: json['overview'] ?? '',
        posterPath: json['poster_path'] ?? '',
        seasonNumber: json['season_number'],
        episodeCount: json['episode_count'],
      );
}
