import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../providers/home_provider.dart';
import '../../widgets/continue_learning_card.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/track_selector_card.dart';
import '../track/track_screen.dart';
import '../study/study_screen.dart';

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
            _Header(name: provider.stats.displayName, streak: provider.stats.dayStreak),
            const SizedBox(height: 20),
            const _SearchBar(),
            const SizedBox(height: 20),
            const _PracticeBanner(),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Choose Your Track', trailing: 'See all'),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: provider.tracks
                  .map((track) => TrackSelectorCard(
                        track: track,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TrackScreen(trackId: track.id, trackName: track.name),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Continue Learning'),
            const SizedBox(height: 12),
            ContinueLearningCard(
              topic: continueTopic,
              trackName: 'Backend',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StudyScreen(topicId: continueTopic.id, topicName: continueTopic.name),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Your Stats', trailing: 'See details'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.local_fire_department_rounded,
                    color: AppColors.streak,
                    value: '${provider.stats.dayStreak}',
                    label: 'Day Streak',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: StatCard(
                    icon: Icons.star_rounded,
                    color: AppColors.accuracy,
                    value: '${provider.stats.accuracyPercent.round()}%',
                    label: 'Accuracy',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: StatCard(
                    icon: Icons.bookmark_rounded,
                    color: AppColors.studied,
                    value: '${provider.stats.cardsStudied}',
                    label: 'Cards Studied',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String name;
  final int streak;
  const _Header({required this.name, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi, $name \ud83d\udc4b',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              const Text("Let's ace your next interview!",
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.streak.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.local_fire_department_rounded, color: AppColors.streak, size: 16),
              const SizedBox(width: 4),
              Text('$streak Days\nStreak',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.streak, height: 1.1)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search topics, e.g. REST API...',
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _PracticeBanner extends StatelessWidget {
  const _PracticeBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: AppColors.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Practice Today',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                SizedBox(height: 4),
                Text('Get One Step Closer To Your Dream Job',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.track_changes_rounded, color: Colors.white, size: 36),
        ],
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
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textPrimary)),
        const Spacer(),
        if (trailing != null)
          Text('$trailing \u2192',
              style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
