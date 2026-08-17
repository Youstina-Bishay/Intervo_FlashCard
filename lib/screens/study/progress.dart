import 'package:flutter/material.dart';

import '../../core/widgets/progress_bar.dart';
import '../../providers/study_provider.dart';
import '../../theme/app_colors.dart';

class Progress extends StatelessWidget {
  const Progress({
    super.key,
    required this.provider,
    required this.color,
  });

  final StudyProvider provider;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${provider.progressCount} / ${provider.cards.length}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),

              const Spacer(),

              Text(
                '${provider.progressPercent}%',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ThinProgressBar(
            value: provider.progressRatio,
            color: color,
            height: 4,
          ),
        ],
      ),
    );
  }
}
