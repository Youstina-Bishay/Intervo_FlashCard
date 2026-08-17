import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const RoundIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;

    return Material(
      color: Colors.white,
      elevation: 2,
      shape: const CircleBorder(
        side: BorderSide(
          color: AppColors.cardBorder,
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(
            icon,
            color: disabled
                ? AppColors.textMuted
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
