import 'package:flutter/material.dart';

import 'cardFace.dart';

class ImageFlashcard extends StatelessWidget {
  final String trackId;
  final String question;
  final String answer;
  final bool showAnswer;
  final bool isBookmarked;
  final Color accentColor;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;

  const ImageFlashcard({
    super.key,
    required this.trackId,
    required this.question,
    required this.answer,
    required this.showAnswer,
    required this.isBookmarked,
    required this.accentColor,
    required this.onTap,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 500,
        ),
        transitionBuilder: (
            Widget child,
            Animation<double> animation,
            ) {
          final rotate = Tween<double>(
            begin: 1,
            end: 0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          );

          return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (
                context,
                child,
                ) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(rotate.value),
                child: child,
              );
            },
          );
        },
        child: CardFace(
          trackId : trackId,
          key: ValueKey(showAnswer),
          text: showAnswer ? answer : question,
          isAnswer: showAnswer,
          isBookmarked: isBookmarked,
          accentColor: accentColor,
          onBookmarkTap: onBookmarkTap,
        ),
      ),
    );
  }
}
