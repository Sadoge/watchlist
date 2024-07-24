import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watchlist/src/features/shared/widgets/styled_text.dart';
import 'package:watchlist/src/features/watch_providers/presentation/providers/watch_providers_provider.dart';

class WatchProviderListDisplay extends ConsumerWidget {
  final int seriesId;

  const WatchProviderListDisplay({
    super.key,
    required this.seriesId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchProvidersState =
        ref.watch(watchProvidersNotifierProvider(seriesId));

    return watchProvidersState.when(
      data: (providers) => providers.isEmpty
          ? const Text('No providers available')
          : Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: providers.map((provider) {
                return Column(
                  children: [
                    if (provider.logoPath.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${provider.logoPath}',
                        width: 50,
                      ),
                    StyledText(text: provider.providerName),
                  ],
                );
              }).toList(),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          const Center(child: StyledText(text: 'Failed to load providers')),
    );
  }
}
