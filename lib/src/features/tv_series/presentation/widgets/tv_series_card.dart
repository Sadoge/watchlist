import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/src/features/tv_series/domain/entities/tv_series.dart';
import 'package:watchlist/src/shared/widgets/styled_text.dart';

class TVSeriesCard extends StatelessWidget {
  final TVSeries tvSeries;
  final VoidCallback? onAdd;
  final bool isSaved;
  final bool showStatus;

  const TVSeriesCard({
    super.key,
    required this.tvSeries,
    this.onAdd,
    this.isSaved = false,
    this.showStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: tvSeries.posterPath.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100,
                          height: 150,
                          color: Colors.grey,
                          child: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                ),
                if (isSaved && showStatus) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.tv, size: 20, color: Colors.grey),
                      const SizedBox(width: 5),
                      StyledText(text: tvSeries.status),
                    ],
                  ),
                  if (tvSeries.lastEpisode.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.play_arrow,
                            size: 20, color: Colors.grey),
                        const SizedBox(width: 5),
                        StyledText(text: tvSeries.lastEpisode),
                      ],
                    ),
                ],
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText(
                    text: tvSeries.name,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      StyledText(
                        text: tvSeries.voteAverage.toStringAsFixed(1),
                        fontSize: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  StyledText(
                    text: tvSeries.overview,
                    isMultiLine: true,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
            if (onAdd != null && !isSaved)
              IconButton(
                icon: const Icon(Icons.add, color: Colors.blue),
                onPressed: onAdd,
              ),
          ],
        ),
      ),
    );
  }
}
