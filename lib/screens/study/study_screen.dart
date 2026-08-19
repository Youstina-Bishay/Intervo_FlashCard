import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/presentation/cubit/topicCubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/di/injection.dart';
import '../../presentation/cubit/topicState.dart';
import '../../theme/app_colors.dart';
import 'centerActionButton.dart';
import 'imageFlashCard.dart';
import 'progress.dart';
import 'roundIconButton.dart';
import 'trackBar.dart';

class StudyScreen extends StatelessWidget {
  final String topicId;
  final String trackId;
  final String topicName;

  const StudyScreen({
    super.key,
    required this.topicId,
    required this.trackId,
    required this.topicName,
  });

  Widget build(BuildContext context) {
    final repo = createHomeRepo();
    return BlocProvider(
      create: (context) => TopicCubit(
        repo: repo,
      )..getAllQuestions(trackId, topicName),
      child: _StudyScreenView(
          topicId: topicId, trackId: trackId, topicName: topicName),
    );
  }
}

class _StudyScreenView extends StatefulWidget {
  final String topicId;
  final String trackId;
  final String topicName;

  const _StudyScreenView({
    super.key,
    required this.topicId,
    required this.trackId,
    required this.topicName,
  });

  @override
  State<_StudyScreenView> createState() => _StudyScreenViewState();
}

class _StudyScreenViewState extends State<_StudyScreenView> {
  int currentIndex = 0;
  bool showAnswer = false;
  final Set<int> bookmarkedCards = {};

  String get _progressKey => 'progress_${widget.trackId}_${widget.topicId}';

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt(_progressKey);
    if (savedIndex != null && mounted) {
      setState(() {
        currentIndex = savedIndex;
      });
    }
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_progressKey, currentIndex);
  }

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

  void next(int totalCards) {
    if (currentIndex < totalCards - 1) {
      setState(() {
        currentIndex++;
        showAnswer = false;
      });
      _saveProgress();
    }
  }

  void previous() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        showAnswer = false;
      });
      _saveProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.trackColor(widget.topicId);

    return BlocBuilder<TopicCubit, TopicState>(
      builder: (context, state) {
        if (state.status == TopicStatus.loading ||
            state.status == TopicStatus.initial) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (state.status == TopicStatus.error) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Text(
                  state.errorMessage ?? 'Something went wrong',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }

        final questions = state.questions;

        if (questions.isEmpty) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Text(
                  'No flashcards in this topic yet.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }

        final safeIndex = currentIndex.clamp(0, questions.length - 1);
        final card = questions[safeIndex];

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
                        trackId: widget.trackId,
                        question: card.question,
                        answer: card.answer,
                        showAnswer: showAnswer,
                        isBookmarked: bookmarkedCards.contains(safeIndex),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: safeIndex > 0 ? previous : null,
                      ),
                      CenterActionButton(
                        label: showAnswer ? 'Hide Answer' : 'Show Answer',
                        icon: showAnswer
                            ? Icons.visibility_off_rounded
                            : Icons.sync_rounded,
                        onTap: toggleAnswer,
                      ),
                      RoundIconButton(
                        icon: Icons.arrow_forward_rounded,
                        onTap: safeIndex < questions.length - 1
                            ? () => next(questions.length)
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
