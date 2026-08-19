import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../core/widgets/progress_bar.dart';
import '../models/topic.dart';

class TopicListItem extends StatelessWidget {
  final Topic topic;
  final VoidCallback onTap;
  final Color color ;

  const TopicListItem({super.key, required this.topic, required this.onTap,required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.add, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '  nummmmmmmmm cards',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    ThinProgressBar(value: 5, color: color),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    '500000%',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12, color: color),
                  ),
                  const SizedBox(height: 4),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
