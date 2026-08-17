import 'package:flutter/material.dart';
import 'package:intervo/screens/study/progress.dart';
import 'package:intervo/screens/study/roundIconButton.dart';
import 'package:intervo/screens/study/trackBar.dart';
import 'package:provider/provider.dart';

import '../../core/constants/appAssets.dart';
import '../../core/constants/icon_map.dart';
import '../../theme/app_colors.dart';
import '../../core/widgets/progress_bar.dart';
import '../../providers/study_provider.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../add_flashcard/add_flashcard_screen.dart';
import 'centerActionButton.dart';
import 'imageFlashCard.dart';

class StudyScreen extends StatelessWidget {
  final String topicId;
  final String topicName;

  const StudyScreen({
    super.key,
    required this.topicId,
    required this.topicName,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudyProvider(topicId: topicId),
      child: _StudyView(
        topicId: topicId,
        topicName: topicName,
      ),
    );
  }
}

class _StudyView extends StatelessWidget {
  final String topicId;
  final String topicName;

  const _StudyView({
    required this.topicId,
    required this.topicName,
  });


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudyProvider>();
    final color = AppColors.trackColor(topicId);

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (provider.cards.isEmpty) {
              return const Center(
                child: Text(
                  'No flashcards in this topic yet.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }

            final card = provider.currentCard!;

            return Column(
              children: [
                TrackBar(topicName: topicName),

                Progress(provider: provider, color: color),

                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ImageFlashcard(
                        question: card.question,
                        answer: card.answer,
                        showAnswer: provider.showAnswer,
                        isBookmarked: card.isBookmarked,
                        topicIcon: iconForKey(topicId),
                        accentColor: color,
                        onTap: provider.toggleAnswer,
                        onBookmarkTap: provider.toggleBookmark,
                      ),
                    ),
                  ),
                ),

                if (!provider.showAnswer)
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.touch_app_rounded,
                          size: 15,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Tap to show answer',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    20,
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      RoundIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: provider.currentIndex > 0
                            ? provider.previous
                            : null,
                      ),

                      CenterActionButton(
                        label: provider.showAnswer
                            ? 'Hide Answer'
                            : 'Show Answer',
                        icon: provider.showAnswer
                            ? Icons.visibility_off_rounded
                            : Icons.sync_rounded,
                        onTap: provider.toggleAnswer,
                      ),

                      RoundIconButton(
                        icon: Icons.arrow_forward_rounded,
                        onTap: provider.currentIndex <
                            provider.cards.length - 1
                            ? provider.next
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}






