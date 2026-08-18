import 'package:flutter/material.dart';

import '../core/constants/appAssets.dart';
import '../theme/app_colors.dart';

class TrackUI {

  final String image;
  final Color color;

  const TrackUI({
    required this.image,
    required this.color,
  });
}

TrackUI getTrackUI(String trackId) {
  switch (trackId) {
    case 'Flutter':
      return const TrackUI(
        image: AppAssets.flutter,
        color: AppColors.flutter,
      );

    case 'backend':
      return const TrackUI(
        image: AppAssets.back,
        color: AppColors.backend,
      );

    case 'frontend':
      return const TrackUI(
        image: AppAssets.front,
        color: AppColors.frontend,
      );

    case 'devops':
      return const TrackUI(
        image: AppAssets.devops,
        color: AppColors.devops,
      );

    default:
      return const TrackUI(
        image: 'assets/images/default.png',
        color: Colors.grey,
      );
  }
}