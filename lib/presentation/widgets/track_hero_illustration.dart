import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Decorative header graphic for the Track screen — a soft floating stack
/// of shapes evoking "structured data" (cloud, layered blocks, code
/// brackets), built entirely from Flutter primitives so no image assets
/// are needed. Gently bobs up and down for a bit of life.
class TrackHeroIllustration extends StatefulWidget {
  final Color color;
  final String image;

  const TrackHeroIllustration({super.key, required this.color, required this.image});

  @override
  State<TrackHeroIllustration> createState() => _TrackHeroIllustrationState();
}

class _TrackHeroIllustrationState extends State<TrackHeroIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final dy = -6 * _controller.value;
        return Transform.translate(offset: Offset(0, dy), child: child);
      },

        child: Image.asset(widget.image),
    );
  }
}
