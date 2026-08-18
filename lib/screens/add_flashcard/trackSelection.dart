import 'package:flutter/material.dart';
import 'package:intervo/models/track.dart';
import 'package:intervo/screens/add_flashcard/trackCard.dart';

import '../../models/trackUI.dart';
import '../../theme/app_colors.dart';

class TrackSelection extends StatelessWidget {
  final List<Track> tracks;
  final List<TrackUI> tracksUI;
  final Function(Track, TrackUI) onTrackSelected;

  const TrackSelection({
    super.key,
    required this.tracks,
    required this.tracksUI,
    required this.onTrackSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose a Track',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Select the track for your interview question.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: tracks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final track = tracks[index];
                final trackUI = getTrackUI(track.id);
                return TrackCard(
                  name: track.name,
                  image: trackUI.image,
                  color: trackUI.color,
                  questions: track.totalQuestions,
                  onTap: () {
                    onTrackSelected(
                      track,
                      trackUI,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
