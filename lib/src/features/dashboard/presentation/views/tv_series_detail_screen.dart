import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';
import 'package:watchlist/src/features/dashboard/presentation/providers/tv_series_detail_provider.dart';
import 'package:watchlist/src/features/dashboard/presentation/providers/watchlist_provider.dart';
import 'package:watchlist/src/features/season/presentation/views/season_detail_screen.dart';
import 'package:watchlist/src/features/dashboard/presentation/widgets/tv_series_dialog.dart';
import 'package:watchlist/src/features/shared/widgets/styled_text.dart';
import 'package:watchlist/src/features/watch_providers/presentation/widgets/watch_providers_list_display.dart';

class TVSeriesDetailScreen extends ConsumerWidget {
  final TVSeries series;

  const TVSeriesDetailScreen({super.key, required this.series});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvSeriesDetailState =
        ref.watch(tvSeriesDetailNotifierProvider(series.id));

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: GoogleFonts.montserrat()
            .copyWith(color: Colors.black, fontSize: 20),
        title: const Text('TV Series Detail'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => TVSeriesStatusDialog(tvSeries: series),
              ).then((value) {
                if (value != null && value is TVSeries) {
                  ref
                      .read(watchlistNotifierProvider.notifier)
                      .updateTVSeries(value);
                }
              });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: tvSeriesDetailState.when(
        data: (tvSeriesDetail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tvSeriesDetail.posterPath.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              StyledText(
                text: tvSeriesDetail.name,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  StyledText(
                    text: tvSeriesDetail.voteAverage.toStringAsFixed(1),
                    fontSize: 18,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StyledText(
                text:
                    'First Air Date: ${_formatDate(tvSeriesDetail.firstAirDate)}',
                fontSize: 18,
              ),
              const SizedBox(height: 8),
              StyledText(
                text:
                    'Last Air Date: ${_formatDate(tvSeriesDetail.lastAirDate)}',
                fontSize: 18,
              ),
              const SizedBox(height: 8),
              StyledText(
                text: 'Seasons: ${tvSeriesDetail.numberOfSeasons}',
                fontSize: 18,
              ),
              const SizedBox(height: 8),
              StyledText(
                text: 'Episodes: ${tvSeriesDetail.numberOfEpisodes}',
                fontSize: 18,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const StyledText(
                text: 'Overview',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              StyledText(
                text: tvSeriesDetail.overview,
                fontSize: 16,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const StyledText(
                text: 'Genres',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: tvSeriesDetail.genres
                    .map((genre) => Chip(
                            label: Text(
                          genre,
                          style: GoogleFonts.montserrat(),
                        )))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const StyledText(
                text: 'Where to Watch',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              WatchProviderListDisplay(seriesId: series.id),
              const SizedBox(height: 16),
              const StyledText(
                text: 'Seasons',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              ...tvSeriesDetail.seasons.map(
                (season) => Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: season.posterPath.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${season.posterPath}',
                            width: 50,
                          )
                        : Container(width: 50, color: Colors.grey),
                    title: StyledText(text: season.name),
                    subtitle:
                        StyledText(text: 'Episodes: ${season.episodeCount}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SeasonDetailScreen(
                            seriesId: series.id,
                            seasonNumber: season.seasonNumber,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: StyledText(text: error.toString())),
      ),
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty) return 'N/A';
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
