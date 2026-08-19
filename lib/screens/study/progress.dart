import 'package:flutter/material.dart';

import '../../core/widgets/progress_bar.dart';
import '../../theme/app_colors.dart';

class Progress extends StatelessWidget {
  const Progress({
    super.key,
    required this.color,
  });

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
                '////// / ',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),

              const Spacer(),

              Text(
                '5000000%',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ThinProgressBar(
            value: 5,
            color: color,
            height: 4,
          ),
        ],
      ),
    );
  }
}
