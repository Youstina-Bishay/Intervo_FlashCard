import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/track_provider.dart';
import 'TrackView.dart';

class TrackScreen extends StatelessWidget {
  final String trackId;
  final String trackName;
  final String image;
  final Color color;

  const TrackScreen({
    super.key,
    required this.trackId,
    required this.trackName,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrackProvider(trackId: trackId),
      child: TrackView(
        trackId: trackId,
        trackName: trackName,
        image: image,
        color: color,
      ),
    );
  }
}




