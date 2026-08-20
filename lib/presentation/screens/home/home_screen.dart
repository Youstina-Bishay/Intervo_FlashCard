import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/core/di/injection.dart';
import 'package:intervo/presentation/cubit/homeCubit.dart';
import 'package:intervo/core/constants/screenSize.dart';
import 'package:intervo/presentation/widgets/track_selector_card.dart';
import '../../../domain/models/trackUI.dart';
import '../../cubit/HomeState.dart';
import '../track/track_screen.dart';
import '../../../core/theme/app_colors.dart';
import 'PracticeBanner.dart';
import 'TipOfTheDayCard.dart';
import 'header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
 final repo= createHomeRepo();
    return BlocProvider(
      // .. Cascade notation
      create: (_) => HomeCubit(repo: repo)..getAllTracks(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final tracks = state.tracks ?? [];

        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                20,
                12,
                20,
                24,
              ),
              children: [
                const Header(),

                const SizedBox(height: 20),

                const PracticeBanner(),

                const SizedBox(height: 24),

                const _SectionTitle(
                  title: 'Choose Your Track',
                  trailing: 'See all',
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: ScreenSize.height(context) * .26,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];

                      final trackUI = getTrackUI(track.id);

                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 12,
                        ),
                        child: SizedBox(
                          width: 170,
                          child: TrackSelectorCard(
                            track: track,
                            trackUI: trackUI,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => TrackScreen(
                                    trackId: track.id,
                                    trackName: track.name,
                                    image: trackUI.image,
                                    color: trackUI.color,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                const TipOfTheDayCard(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;

  const _SectionTitle({
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        if (trailing != null)
          Text(
            '$trailing →',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
