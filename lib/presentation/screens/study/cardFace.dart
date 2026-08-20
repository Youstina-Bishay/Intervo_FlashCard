import 'package:flutter/material.dart';

import '../../../core/constants/appAssets.dart';
import '../../../core/theme/app_colors.dart';

class CardFace extends StatelessWidget {
  final String trackId;
  final String text;
  final bool isAnswer;
  final bool isBookmarked;
  final Color accentColor;
  final VoidCallback onBookmarkTap;

  const CardFace({
    super.key,
    required this.text,
    required this.trackId,
    required this.isAnswer,
    required this.isBookmarked,
    required this.accentColor,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.72,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.getQuestionImage(trackId),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 35,
            left: 25,
            right: 25,
            bottom: 35,
            child: Column(
              children: [

                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const SizedBox(height: 30),

                        SizedBox(
                          width: 220,
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: isAnswer ? 15 : 17,
                              height: 1.35,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}