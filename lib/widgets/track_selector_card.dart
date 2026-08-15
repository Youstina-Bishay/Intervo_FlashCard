import 'package:flutter/material.dart';
import '../core/constants/icon_map.dart';
import '../theme/app_colors.dart';
import '../models/track.dart';

class TrackSelectorCard extends StatelessWidget {
  final Track track;
  final VoidCallback onTap;

  const TrackSelectorCard({super.key, required this.track, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.trackColor(track.iconKey);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconForKey(track.iconKey), color: color, size: 22),
              ),
              const SizedBox(height: 14),
              Text(
                track.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '${track.totalQuestions}+ Questions',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_rounded, size: 16, color: color),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
