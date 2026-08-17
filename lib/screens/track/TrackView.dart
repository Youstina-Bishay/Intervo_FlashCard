import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/topic_list_item.dart';
import '../study/study_screen.dart';
import 'HeroSection.dart';

class TrackView extends StatelessWidget {
  final String trackId;
  final String trackName;
  final String image;
  final Color color;

  const TrackView({
    required this.trackId,
    required this.trackName,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              HeroSection(color: color, trackName: trackName, image: image),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.textSecondary,

                    labelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),

                    unselectedLabelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),

                    indicator: BoxDecoration(
                      color: color,
                      border: BoxBorder.all(color: Colors.black26,width: 2),
                      borderRadius: BorderRadius.circular(22),
                    ),

                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,

                    overlayColor:
                    WidgetStateProperty.all(Colors.transparent),

                    tabs: const [
                      Tab(
                        text: 'Topics',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Expanded(
                child: TabBarView(
                  children: [
                    _TopicsTab(
                      tracks: [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _TopicsTab extends StatelessWidget {
  final List tracks;

  const _TopicsTab({
    required this.tracks,
  });

  @override
  Widget build(BuildContext context) {
    if (tracks.isEmpty) {
      return const Center(
        child: Text(
          'No topics yet.',
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        20,
      ),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final topic = tracks[index];

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: TopicListItem(
            topic: topic,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => StudyScreen(
                    topicId: topic.id,
                    topicName: topic.name,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

