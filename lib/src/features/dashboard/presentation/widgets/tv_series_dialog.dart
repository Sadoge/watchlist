import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watchlist/src/features/dashboard/domain/entities/tv_series.dart';

class TVSeriesStatusDialog extends StatefulWidget {
  final TVSeries tvSeries;

  const TVSeriesStatusDialog({super.key, required this.tvSeries});

  @override
  State<TVSeriesStatusDialog> createState() => _TVSeriesStatusDialogState();
}

class _TVSeriesStatusDialogState extends State<TVSeriesStatusDialog> {
  late String _status;
  late TextEditingController _lastEpisodeController;

  @override
  void initState() {
    super.initState();
    _status = widget.tvSeries.status;
    _lastEpisodeController =
        TextEditingController(text: widget.tvSeries.lastEpisode);
  }

  @override
  void dispose() {
    _lastEpisodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: GoogleFonts.montserrat(),
      title: const Text('Update TV Series'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _status,
            onChanged: (value) {
              setState(() {
                _status = value!;
              });
            },
            items: ['Watching', 'Want to Watch'].map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(
                  status,
                  style: GoogleFonts.montserrat(),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Status',
              labelStyle: GoogleFonts.montserrat(),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _lastEpisodeController,
            style: GoogleFonts.montserrat(),
            decoration: InputDecoration(
              labelText: 'Last Episode Watched',
              labelStyle: GoogleFonts.montserrat(),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.montserrat(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedSeries = TVSeries(
              id: widget.tvSeries.id,
              name: widget.tvSeries.name,
              overview: widget.tvSeries.overview,
              posterPath: widget.tvSeries.posterPath,
              voteAverage: widget.tvSeries.voteAverage,
              status: _status,
              lastEpisode: _lastEpisodeController.text,
            );
            Navigator.of(context).pop(updatedSeries);
          },
          child: Text(
            'Save',
            style: GoogleFonts.montserrat(),
          ),
        ),
      ],
    );
  }
}
