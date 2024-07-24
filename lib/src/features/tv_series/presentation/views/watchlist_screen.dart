import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watchlist/src/features/tv_series/presentation/providers/watchlist_provider.dart';
import 'package:watchlist/src/features/tv_series/presentation/views/tv_series_detail_screen.dart';
import 'package:watchlist/src/features/tv_series/presentation/widgets/tv_series_card.dart';

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistState = ref.watch(watchlistNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: GoogleFonts.montserrat()
            .copyWith(color: Colors.black, fontSize: 20),
        title: const Text('Watchlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await ref
                  .read(watchlistNotifierProvider.notifier)
                  .exportWatchlist();
            },
          ),
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () async {
              await ref
                  .read(watchlistNotifierProvider.notifier)
                  .importWatchlist();
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (String result) {
              ref
                  .read(watchlistNotifierProvider.notifier)
                  .loadSavedTVSeries(status: result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '',
                child: Text('All'),
              ),
              const PopupMenuItem<String>(
                value: 'watching',
                child: Text('Watching'),
              ),
              const PopupMenuItem<String>(
                value: 'want to watch',
                child: Text('Want to Watch'),
              ),
            ],
          ),
        ],
      ),
      body: watchlistState.when(
        data: (tvSeries) => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: tvSeries.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final series = tvSeries[index];
            return Dismissible(
              key: Key(series.id.toString()),
              onDismissed: (direction) {
                ref
                    .read(watchlistNotifierProvider.notifier)
                    .removeTVSeries(series.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('${series.name} removed from watchlist')),
                );
              },
              background: Container(color: Colors.red),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TVSeriesDetailScreen(series: series),
                    ),
                  );
                },
                child: TVSeriesCard(
                  tvSeries: series,
                  isSaved: true,
                  showStatus: true,
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
