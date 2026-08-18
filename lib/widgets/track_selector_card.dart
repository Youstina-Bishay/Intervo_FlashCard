import 'package:flutter/material.dart';
import 'package:intervo/core/constants/screenSize.dart';
import 'package:intervo/models/trackUI.dart';
import '../theme/app_colors.dart';
import '../models/track.dart';

class TrackSelectorCard extends StatelessWidget {
  final Track track;
  final VoidCallback onTap;
final TrackUI trackUI;
  const TrackSelectorCard({
    super.key,
    required this.track,
    required this.trackUI,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final trackColor = AppColors.trackColor(track.name);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: ScreenSize.width(context) * .42,
          height: ScreenSize.height(context) * .22,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.45),
                trackColor.withOpacity(.2),
                Colors.white.withOpacity(.45),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.cardBorder,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: trackColor.withOpacity(.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Track Image
              Expanded(
                child: Center(
                  child: Image.asset(
                    trackUI.image,
                    width: ScreenSize.width(context) * .35,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Track Name
              Text(
                track.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 3),

              // Questions + Arrow
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '25+ Questions',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(width: 5),

                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: trackColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}