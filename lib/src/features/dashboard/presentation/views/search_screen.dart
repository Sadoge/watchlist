import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watchlist/src/features/dashboard/presentation/providers/tv_series_provider.dart';
import 'package:watchlist/src/features/dashboard/presentation/providers/watchlist_provider.dart';
import 'package:watchlist/src/features/dashboard/presentation/widgets/tv_series_card.dart';
import 'package:watchlist/src/features/shared/widgets/styled_text.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final tvSeriesState = ref.watch(tvSeriesNotifierProvider);
    final watchlistNotifier = ref.watch(watchlistNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: GoogleFonts.montserrat()
            .copyWith(color: Colors.black, fontSize: 20),
        title: const Text('Search TV Series'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.montserrat(),
              decoration: InputDecoration(
                labelText: 'Search TV Series',
                labelStyle: GoogleFonts.montserrat(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      setState(() {
                        _isSearching = true;
                      });

                      ref
                          .read(tvSeriesNotifierProvider.notifier)
                          .searchTVSeries(_searchController.text);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: tvSeriesState.when(
              data: (tvSeries) => ListView.separated(
                itemCount: tvSeries.length,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final series = tvSeries[index];
                  final isSaved = watchlistNotifier.isSeriesSaved(series.id);

                  return TVSeriesCard(
                    tvSeries: series,
                    isSaved: isSaved,
                    onAdd: isSaved
                        ? null
                        : () {
                            ref
                                .read(watchlistNotifierProvider.notifier)
                                .addTVSeries(series);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: StyledText(
                                    text: '${series.name} added to watchlist'),
                              ),
                            );
                          },
                  );
                },
              ),
              loading: () => _isSearching
                  ? const Center(child: CircularProgressIndicator())
                  : const Center(
                      child: StyledText(text: 'Please enter a search term')),
              error: (error, _) => Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
