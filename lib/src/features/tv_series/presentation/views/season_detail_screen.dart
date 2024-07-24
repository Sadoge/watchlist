import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:watchlist/src/features/tv_series/presentation/providers/series_provider.dart';
import 'package:watchlist/src/shared/widgets/styled_text.dart';

class SeasonDetailScreen extends ConsumerWidget {
  final int seriesId;
  final int seasonNumber;

  const SeasonDetailScreen({
    super.key,
    required this.seriesId,
    required this.seasonNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasonDetailState =
        ref.watch(seasonDetailNotifierProvider(Tuple2(seriesId, seasonNumber)));

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: GoogleFonts.montserrat()
            .copyWith(color: Colors.black, fontSize: 20),
        title: Text(
          'Season $seasonNumber Details',
        ),
      ),
      body: seasonDetailState.when(
        data: (seasonDetail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (seasonDetail.posterPath.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${seasonDetail.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              StyledText(
                text: seasonDetail.name,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 16),
              const StyledText(
                text: 'Overview',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              StyledText(
                text: seasonDetail.overview,
                fontSize: 16,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const StyledText(
                text: 'Episodes',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              ...seasonDetail.episodes.map(
                (episode) => Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: episode.stillPath.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                            width: 50,
                          )
                        : Container(width: 50, color: Colors.grey),
                    title: StyledText(
                        text:
                            'Episode ${episode.episodeNumber}: ${episode.name}'),
                    subtitle: StyledText(
                        text:
                            'Air Date: ${_formatDate(episode.airDate)}\n${episode.overview}'),
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty) return 'N/A';
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
