import 'package:hive/hive.dart';

part 'tv_series_model.g.dart';

@HiveType(typeId: 0)
class TVSeriesModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String overview;
  @HiveField(3)
  final String? posterPath;
  @HiveField(4)
  final double voteAverage;
  @HiveField(5)
  final String? status;
  @HiveField(6)
  final String? lastEpisode;

  TVSeriesModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.status,
    required this.lastEpisode,
  });

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      status: json['status'] ?? 'Want to Watch',
      lastEpisode: json['last_episode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'status': status,
      'last_episode': lastEpisode,
    };
  }
}
