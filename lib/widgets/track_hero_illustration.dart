import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Decorative header graphic for the Track screen — a soft floating stack
/// of shapes evoking "structured data" (cloud, layered blocks, code
/// brackets), built entirely from Flutter primitives so no image assets
/// are needed. Gently bobs up and down for a bit of life.
class TrackHeroIllustration extends StatefulWidget {
  final Color color;
  final IconData icon;

  const TrackHeroIllustration({super.key, required this.color, required this.icon});

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
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [widget.color.withOpacity(0.18), widget.color.withOpacity(0.06)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [widget.color, widget.color.withOpacity(0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(widget.icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
