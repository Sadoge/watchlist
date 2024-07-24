import 'package:watchlist/src/features/season/domain/entities/episode.dart';

class EpisodeModel extends Episode {
  EpisodeModel({
    required super.id,
    required super.name,
    required super.overview,
    required super.airDate,
    required super.episodeNumber,
    required super.stillPath,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json['id'],
        name: json['name'],
        overview: json['overview'] ?? '',
        airDate: json['air_date'] ?? '',
        episodeNumber: json['episode_number'],
        stillPath: json['still_path'] ?? '',
      );
}
