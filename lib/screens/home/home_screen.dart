import 'package:flutter/material.dart';
import 'package:intervo/core/constants/screenSize.dart';
import 'package:intervo/screens/home/statsRow.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../providers/home_provider.dart';
import '../../widgets/continue_learning_card.dart';
import '../../widgets/track_selector_card.dart';
import '../track/track_screen.dart';
import '../study/study_screen.dart';
import 'PracticeBanner.dart';
import 'header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final continueTopic = provider.continueLearningTopic;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            const Header(),
            const SizedBox(height: 20),
            const PracticeBanner(),
            const SizedBox(height: 24),
            const _SectionTitle(
                title: 'Choose Your Track', trailing: 'See all'),
            const SizedBox(height: 12),
            SizedBox(
              height:ScreenSize.height(context)*.26,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.tracks.length,
                itemBuilder: (context, index) {
                  final track = provider.tracks[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 170,
                      child: TrackSelectorCard(
                        track: track,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TrackScreen(
                              trackId: track.id,
                              trackName: track.name,
                              image: track.image,
                              color: track.color,
                            ),
                          ),
                        ),

                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Continue Learning'),
            const SizedBox(height: 12),
            ContinueLearningCard(
              topic: continueTopic,
              trackName: 'Backend',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StudyScreen(
                      topicId: continueTopic.id, topicName: continueTopic.name),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Your Stats', trailing: 'See details'),
            const SizedBox(height: 12),
            StatsRow()
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;

  const _SectionTitle({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.textPrimary)),
        const Spacer(),
        if (trailing != null)
          Text('$trailing \u2192',
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600)),
      ],
    );
  }
}
