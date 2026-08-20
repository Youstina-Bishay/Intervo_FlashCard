import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SectionLabel extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionLabel({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: AppColors.primary,
        ),

        const SizedBox(width: 7),

        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
