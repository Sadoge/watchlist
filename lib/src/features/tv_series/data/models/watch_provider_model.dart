import 'package:watchlist/src/features/tv_series/domain/entities/watch_provider.dart';

class WatchProviderModel extends WatchProvider {
  WatchProviderModel({
    required super.providerName,
    required super.logoPath,
  });

  factory WatchProviderModel.fromJson(Map<String, dynamic> json) {
    return WatchProviderModel(
      providerName: json['provider_name'],
      logoPath: json['logo_path'],
    );
  }
}
