import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// The main flashcard widget. Flips between question and answer sides on
/// tap, driven by [showAnswer] so the parent screen stays the single
/// source of truth for study progress.
///
/// Animation layers, all driven off one [AnimationController]:
///  1. A 3D Y-axis rotation (perspective transform) for the flip itself.
///  2. A brief scale "pop" at the midpoint of the flip (card looks like it
///     lifts slightly off the stack as it turns).
///  3. Two static offset cards behind the main one for a stacked-deck look,
///     which fade/settle slightly as the top card flips.
class FlipFlashcard extends StatefulWidget {
  final String question;
  final String answer;
  final bool showAnswer;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;
  final bool isBookmarked;
  final IconData topicIcon;
  final Color accentColor;

  const FlipFlashcard({
    super.key,
    required this.question,
    required this.answer,
    required this.showAnswer,
    required this.onTap,
    required this.onBookmarkTap,
    required this.topicIcon,
    required this.accentColor,
    this.isBookmarked = false,
  });

  @override
  State<FlipFlashcard> createState() => _FlipFlashcardState();
}

class _FlipFlashcardState extends State<FlipFlashcard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  late final Animation<double> _flip = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCubic,
  );

  @override
  void didUpdateWidget(covariant FlipFlashcard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showAnswer != oldWidget.showAnswer) {
      widget.showAnswer ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Scale bumps up slightly and back down as the card passes the
  /// halfway point of the flip, so it feels like it's lifting off the
  /// stack rather than rotating in place.
  double _scaleFor(double t) => 1 - (0.06 * sin(t * pi));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Stacked cards behind, giving the deck depth.
            AnimatedBuilder(
              animation: _flip,
              builder: (context, _) {
                final settle = 1 - _flip.value; // most visible at rest
                return Transform.translate(
                  offset: Offset(0, 20 + (4 * settle)),
                  child: Transform.scale(
                    scale: 0.92,
                    child: Container(
                      height: 320,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _flip,
              builder: (context, _) {
                final settle = 1 - _flip.value;
                return Transform.translate(
                  offset: Offset(0, 10 + (2 * settle)),
                  child: Transform.scale(
                    scale: 0.96,
                    child: Container(
                      height: 320,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                    ),
                  ),
                );
              },
            ),
            // The flipping top card.
            AnimatedBuilder(
              animation: _flip,
              builder: (context, child) {
                final angle = _flip.value * pi;
                final isBack = angle > pi / 2;
                final scale = _scaleFor(_flip.value);
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0012)
                    ..rotateY(angle)
                    ..scale(scale),
                  child: isBack
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(pi),
                          child: _CardFace(
                            label: 'Answer',
                            labelColor: AppColors.success,
                            text: widget.answer,
                            isBookmarked: widget.isBookmarked,
                            onBookmarkTap: widget.onBookmarkTap,
                            topicIcon: widget.topicIcon,
                            accentColor: widget.accentColor,
                          ),
                        )
                      : _CardFace(
                          label: 'Question',
                          labelColor: AppColors.primary,
                          text: widget.question,
                          isBookmarked: widget.isBookmarked,
                          onBookmarkTap: widget.onBookmarkTap,
                          hint: 'Tap to show answer',
                          topicIcon: widget.topicIcon,
                          accentColor: widget.accentColor,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  final String label;
  final Color labelColor;
  final String text;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final String? hint;
  final IconData topicIcon;
  final Color accentColor;

  const _CardFace({
    required this.label,
    required this.labelColor,
    required this.text,
    required this.isBookmarked,
    required this.onBookmarkTap,
    required this.topicIcon,
    required this.accentColor,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.14),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Faint watermark icon in the corner, echoing the topic.
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(topicIcon, size: 120, color: accentColor.withOpacity(0.06)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: labelColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          label == 'Question'
                              ? Icons.lightbulb_rounded
                              : Icons.check_circle_rounded,
                          size: 14,
                          color: labelColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: TextStyle(
                            color: labelColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onBookmarkTap,
                    child: Icon(
                      isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      color: isBookmarked ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.45,
                    ),
                  ),
                ),
              ),
              if (hint != null)
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.touch_app_rounded, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 6),
                      Text(
                        hint!,
                        style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
