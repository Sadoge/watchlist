class TVSeries {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final String status;
  final String lastEpisode;

  TVSeries({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.status,
    required this.lastEpisode,
  });

  factory TVSeries.fromJson(Map<String, dynamic> json) {
    return TVSeries(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['posterPath'],
      voteAverage: json['voteAverage'],
      status: json['status'],
      lastEpisode: json['lastEpisode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'status': status,
      'lastEpisode': lastEpisode,
    };
  }
}
