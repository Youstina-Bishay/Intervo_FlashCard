import 'package:flutter/material.dart';
import '../core/constants/icon_map.dart';
import '../theme/app_colors.dart';
import '../models/topic.dart';

/// The "Continue Learning" row on Home — shows the last-studied topic
/// with a play button and inline progress.
class ContinueLearningCard extends StatelessWidget {
  final Topic topic;
  final String trackName;
  final VoidCallback onTap;

  const ContinueLearningCard({
    super.key,
    required this.topic,
    required this.trackName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.trackColor(topic.name);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.access_alarm, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${topic.name} Basics',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(trackName,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: LinearProgressIndicator(
                            value: 5,
                            minHeight: 5,
                            borderRadius: BorderRadius.circular(4),
                            backgroundColor: color.withOpacity(0.15),
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('250 /  cards',
                            style: const TextStyle(
                                fontSize: 11, color: AppColors.textMuted)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
