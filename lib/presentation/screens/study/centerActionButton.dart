import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CenterActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const CenterActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.primary,
          elevation: 5,
          shadowColor: AppColors.primary.withOpacity(.35),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 250,
                ),
                transitionBuilder: (
                    child,
                    animation,
                    ) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
                child: Icon(
                  icon,
                  key: ValueKey(icon),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}