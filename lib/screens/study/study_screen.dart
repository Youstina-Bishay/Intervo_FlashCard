import 'package:flutter/material.dart';

import '../../core/constants/icon_map.dart';
import '../../theme/app_colors.dart';
import 'centerActionButton.dart';
import 'imageFlashCard.dart';
import 'progress.dart';
import 'roundIconButton.dart';
import 'trackBar.dart';

class StudyScreen extends StatefulWidget {
  final String topicId;
  final String topicName;

  const StudyScreen({
    super.key,
    required this.topicId,
    required this.topicName,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final List<Map<String, String>> cards = [
    {
      'question': 'What is Flutter?',
      'answer':
      'Flutter is an open-source UI framework developed by Google for building cross-platform applications.',
    },
    {
      'question': 'What is a Widget in Flutter?',
      'answer':
      'A Widget is the basic building block of a Flutter user interface.',
    },
    {
      'question': 'What is the difference between StatelessWidget and StatefulWidget?',
      'answer':
      'StatelessWidget does not have mutable state, while StatefulWidget can maintain and update its state.',
    },
  ];

  int currentIndex = 0;
  bool showAnswer = false;
  final Set<int> bookmarkedCards = {};

  void toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  void toggleBookmark() {
    setState(() {
      if (bookmarkedCards.contains(currentIndex)) {
        bookmarkedCards.remove(currentIndex);
      } else {
        bookmarkedCards.add(currentIndex);
      }
    });
  }

  void next() {
    if (currentIndex < cards.length - 1) {
      setState(() {
        currentIndex++;
        showAnswer = false;
      });
    }
  }

  void previous() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        showAnswer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.trackColor(widget.topicId);

    if (cards.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Text(
              'No flashcards in this topic yet.',
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      );
    }

    final card = cards[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TrackBar(
              topicName: widget.topicName,
            ),

            Progress(
              color: color,
            ),

            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: ImageFlashcard(
                    question: card['question']!,
                    answer: card['answer']!,
                    showAnswer: showAnswer,
                    isBookmarked: bookmarkedCards.contains(currentIndex),
                    topicIcon: iconForKey(widget.topicId),
                    accentColor: color,
                    onTap: toggleAnswer,
                    onBookmarkTap: toggleBookmark,
                  ),
                ),
              ),
            ),

            if (!showAnswer)
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
                    onTap: currentIndex > 0
                        ? previous
                        : null,
                  ),

                  CenterActionButton(
                    label: showAnswer
                        ? 'Hide Answer'
                        : 'Show Answer',
                    icon: showAnswer
                        ? Icons.visibility_off_rounded
                        : Icons.sync_rounded,
                    onTap: toggleAnswer,
                  ),

                  RoundIconButton(
                    icon: Icons.arrow_forward_rounded,
                    onTap: currentIndex < cards.length - 1
                        ? next
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}