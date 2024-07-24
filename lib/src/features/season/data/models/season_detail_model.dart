import 'package:watchlist/src/features/season/data/models/episode_model.dart';
import 'package:watchlist/src/features/season/domain/entities/season_detail.dart';

class SeasonDetailModel extends SeasonDetail {
  SeasonDetailModel({
    required super.id,
    required super.name,
    required super.overview,
    required super.posterPath,
    required super.seasonNumber,
    required super.episodes,
  });

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        id: json['id'],
        name: json['name'],
        overview: json['overview'] ?? '',
        posterPath: json['poster_path'] ?? '',
        seasonNumber: json['season_number'],
        episodes: (json['episodes'] as List)
            .map((episode) => EpisodeModel.fromJson(episode))
            .toList(),
      );
}
