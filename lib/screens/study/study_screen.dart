import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/icon_map.dart';
import '../../theme/app_colors.dart';
import '../../core/widgets/progress_bar.dart';
import '../../providers/study_provider.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../../widgets/flip_flashcard.dart';
import '../add_flashcard/add_flashcard_screen.dart';

class StudyScreen extends StatelessWidget {
  final String topicId;
  final String topicName;

  const StudyScreen({super.key, required this.topicId, required this.topicName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudyProvider(topicId: topicId),
      child: _StudyView(topicId: topicId, topicName: topicName),
    );
  }
}

class _StudyView extends StatelessWidget {
  final String topicId;
  final String topicName;
  const _StudyView({required this.topicId, required this.topicName});

  Future<void> _confirmDelete(BuildContext context, StudyProvider provider) async {
    final confirmed = await showDeleteFlashcardDialog(context);
    if (confirmed == true) {
      provider.deleteCurrentCard();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flashcard deleted')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudyProvider>();
    final color = AppColors.trackColor(topicId);

    return Scaffold(
      appBar: AppBar(
        title: Text(topicName),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: provider.currentCard == null ? null : () => _confirmDelete(context, provider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (_) => AddFlashcardScreen(initialTopicId: topicId)),
          );
          if (result == true) {
            provider.refresh();
          }
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add'),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          if (provider.cards.isEmpty) {
            return const Center(
              child: Text('No flashcards in this topic yet.',
                  style: TextStyle(color: AppColors.textSecondary)),
            );
          }
          final card = provider.currentCard!;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('${provider.progressCount} / ${provider.cards.length}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const Spacer(),
                    Text('${provider.progressPercent}%',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 8),
                ThinProgressBar(value: provider.progressRatio, color: color),
                const SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: FlipFlashcard(
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RoundIconButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: provider.currentIndex > 0 ? provider.previous : null,
                    ),
                    _CenterActionButton(
                      label: provider.showAnswer ? 'Hide Answer' : 'Show Answer',
                      icon: provider.showAnswer ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      onTap: provider.toggleAnswer,
                    ),
                    _RoundIconButton(
                      icon: Icons.arrow_forward_rounded,
                      onTap: provider.currentIndex < provider.cards.length - 1 ? provider.next : null,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return Material(
      color: Colors.white,
      shape: const CircleBorder(side: BorderSide(color: AppColors.cardBorder)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: disabled ? AppColors.textMuted : AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _CenterActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _CenterActionButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.primary,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => RotationTransition(turns: anim, child: child),
                child: Icon(icon, key: ValueKey(icon), color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }
}
