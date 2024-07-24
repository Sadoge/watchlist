import 'package:watchlist/src/features/season/domain/entities/episode.dart';

class SeasonDetail {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final List<Episode> episodes;

  SeasonDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  int get episodeCount => episodes.length;
}
