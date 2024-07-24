class WatchProvider {
  final String providerName;
  final String logoPath;

  WatchProvider({
    required this.providerName,
    required this.logoPath,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> json) {
    return WatchProvider(
      providerName: json['provider_name'],
      logoPath: json['logo_path'],
    );
  }
}
