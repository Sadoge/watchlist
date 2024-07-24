import 'package:watchlist/src/features/tv_series/domain/entities/season.dart';

class TVSeriesDetail {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<String> genres;
  final String firstAirDate;
  final String lastAirDate;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<Season> seasons;

  TVSeriesDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genres,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.seasons,
  });
}
