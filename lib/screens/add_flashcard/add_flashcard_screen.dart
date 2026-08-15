import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../core/widgets/gradient_button.dart';
import '../../providers/add_flashcard_provider.dart';
import '../../models/topic.dart';

class AddFlashcardScreen extends StatelessWidget {
  final String initialTopicId;

  const AddFlashcardScreen({super.key, required this.initialTopicId});

  @override
  Widget build(BuildContext context) {
    final initialTrackId =
        MockData.topics.firstWhere((t) => t.id == initialTopicId).trackId;
    return ChangeNotifierProvider(
      create: (_) => AddFlashcardProvider(initialTrackId: initialTrackId),
      child: const _AddFlashcardView(),
    );
  }
}

class _AddFlashcardView extends StatelessWidget {
  const _AddFlashcardView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddFlashcardProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Flashcard')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _TrackSegmentedControl(provider: provider),
            const SizedBox(height: 16),
            const Text('Topic', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            _TopicDropdown(provider: provider),
            const SizedBox(height: 16),
            const Text('Question', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: provider.questionController,
              builder: (context, _) => TextField(
                controller: provider.questionController,
                maxLength: AddFlashcardProvider.questionMaxLength,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Enter your question...'),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Answer', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: provider.answerController,
              builder: (context, _) => TextField(
                controller: provider.answerController,
                maxLength: AddFlashcardProvider.answerMaxLength,
                maxLines: 5,
                decoration: const InputDecoration(hintText: 'Enter the answer...'),
              ),
            ),
            const SizedBox(height: 24),
            GradientButton(
              label: 'Save Flashcard',
              icon: Icons.auto_awesome_rounded,
              onPressed: provider.canSave
                  ? () async {
                      provider.save();
                      await _showSavedDialog(context);
                      if (context.mounted) Navigator.of(context).pop(true);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSavedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 16),
              const Text('Flashcard Added!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 6),
              const Text(
                'Your question and answer have been saved successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: GradientButton(label: 'Great!', onPressed: () => Navigator.of(context).pop()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Segmented toggle between the topic's own track and "General" — matches
/// the Backend/Frontend, Database/General, DevOps/General, System
/// Design/General toggles seen across the designs.
class _TrackSegmentedControl extends StatelessWidget {
  final AddFlashcardProvider provider;
  const _TrackSegmentedControl({required this.provider});

  @override
  Widget build(BuildContext context) {
    final options = [
      (id: provider.initialTrackId, label: provider.initialTrackName),
      (id: 'general', label: 'General'),
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: options.map((option) {
          final selected = provider.selectedTrackId == option.id;
          return Expanded(
            child: GestureDetector(
              onTap: () => provider.selectTrack(option.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: selected
                      ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)]
                      : null,
                ),
                child: Text(
                  option.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: selected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TopicDropdown extends StatelessWidget {
  final AddFlashcardProvider provider;
  const _TopicDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    final topics = provider.topicsForSelectedTrack;
    if (topics.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
        child: const Text('No topics in this track yet',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Topic>(
          value: provider.selectedTopic,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: topics
              .map((topic) => DropdownMenuItem(value: topic, child: Text(topic.name)))
              .toList(),
          onChanged: (topic) {
            if (topic != null) provider.selectTopic(topic);
          },
        ),
      ),
    );
  }
}
