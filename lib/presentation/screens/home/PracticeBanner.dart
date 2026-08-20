import 'package:flutter/material.dart';

import '../../../core/constants/appAssets.dart';
import '../../../core/constants/screenSize.dart';
import '../../../core/theme/app_colors.dart';

class PracticeBanner extends StatelessWidget {
  const PracticeBanner();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: ScreenSize.height(context) * .155,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: AppColors.heroGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child:  Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Practice Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: ScreenSize.width(context)*.42,
                      child: const Text(
                        'Get One Step Closer To Your Dream Job',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -30,
          right: -20,
          child: Image.asset(
            AppAssets.arrow,
            width: ScreenSize.width(context) * .45,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
