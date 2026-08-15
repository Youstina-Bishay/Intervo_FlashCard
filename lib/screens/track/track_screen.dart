import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/icon_map.dart';
import '../../theme/app_colors.dart';
import '../../core/widgets/progress_bar.dart';
import '../../providers/track_provider.dart';
import '../../widgets/topic_list_item.dart';
import '../../widgets/track_hero_illustration.dart';
import '../study/study_screen.dart';

class TrackScreen extends StatelessWidget {
  final String trackId;
  final String trackName;

  const TrackScreen({super.key, required this.trackId, required this.trackName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrackProvider(trackId: trackId),
      child: _TrackView(trackId: trackId, trackName: trackName),
    );
  }
}

class _TrackView extends StatelessWidget {
  final String trackId;
  final String trackName;
  const _TrackView({required this.trackId, required this.trackName});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TrackProvider>();
    final color = AppColors.trackColor(trackId);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('$trackName Track'),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.bookmark_border_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        TrackHeroIllustration(color: color, icon: iconForKey(trackId)),
                        const SizedBox(height: 14),
                        Text('$trackName Track',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(
                          'Master the core concepts and be ready for any ${trackName.toLowerCase()} interview.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    tabs: const [Tab(text: 'Topics'), Tab(text: 'Progress')],
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _TopicsTab(provider: provider),
                  _ProgressTab(provider: provider, color: color),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicsTab extends StatelessWidget {
  final TrackProvider provider;
  const _TopicsTab({required this.provider});

  @override
  Widget build(BuildContext context) {
    if (provider.topics.isEmpty) {
      return const Center(
        child: Text('No topics yet.', style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: provider.topics.length,
      itemBuilder: (context, index) {
        final topic = provider.topics[index];
        return TopicListItem(
          topic: topic,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => StudyScreen(topicId: topic.id, topicName: topic.name),
            ),
          ),
        );
      },
    );
  }
}

class _ProgressTab extends StatelessWidget {
  final TrackProvider provider;
  final Color color;
  const _ProgressTab({required this.provider, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Overall progress', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              ThinProgressBar(value: provider.overallProgress, color: color, height: 10),
              const SizedBox(height: 8),
              Text('${(provider.overallProgress * 100).round()}% complete',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...provider.topics.map((topic) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(child: Text(topic.name, style: const TextStyle(fontSize: 13))),
                  SizedBox(
                    width: 120,
                    child: ThinProgressBar(
                      value: topic.progress,
                      color: AppColors.trackColor(topic.iconKey),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${topic.progressPercent}%', style: const TextStyle(fontSize: 12)),
                ],
              ),
            )),
      ],
    );
  }
}
