import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class TrackBar extends StatelessWidget {
  const TrackBar({
    super.key,
    required this.topicName,
  });

  final String topicName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 19,
            ),
          ),

          Expanded(
            child: Text(
              topicName.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
