import 'package:flutter/material.dart';
import 'package:intervo/models/track.dart';
import 'package:intervo/screens/add_flashcard/sectionLabel.dart';

import '../../core/widgets/gradient_button.dart';
import '../../models/trackUI.dart';
import '../../theme/app_colors.dart';
import 'inputCard.dart';

class AddQuestionForm extends StatefulWidget {
  final Track track;
  final TrackUI trackUI;

  const AddQuestionForm({
    super.key,
    required this.track,
    required this.trackUI,
  });

  @override
  State<AddQuestionForm> createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  String selectedTopic = 'General';

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final track = widget.track;
    final trackUI = widget.trackUI;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        32,
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: trackUI.color.withOpacity(.10),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Image.asset(
                  trackUI.image,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adding to',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      '${track.name} Interview',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.public_rounded,
                      size: 14,
                      color: AppColors.success,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Public',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),
        const SectionLabel(
          icon: Icons.category_outlined,
          title: 'Choose a topic',
        ),

        const SizedBox(height: 9),

        TopicDropDownButton(
          value: selectedTopic,
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedTopic = value;
            });
          },
        ),

        const SizedBox(height: 24),


        const SectionLabel(
          icon: Icons.help_outline_rounded,
          title: 'Interview question',
        ),

        const SizedBox(height: 9),

        InputCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.cardBorder,
                  ),
                ),
                child: TextField(
                  controller: questionController,
                  maxLines: 5,
                  maxLength: 300,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText:
                    'e.g. What is the difference between '
                        'let, const and var in JavaScript?',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppColors.textMuted,
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.cardBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.3,
                      ),
                    ),
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 15,
                    color: AppColors.textMuted,
                  ),

                  const SizedBox(width: 6),

                  const Expanded(
                    child: Text(
                      'Keep the question clear and interview-focused.',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),

                  Text(
                    '${questionController.text.length}/300',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        const SectionLabel(
          icon: Icons.check_circle_outline_rounded,
          title: 'Answer',
        ),

        const SizedBox(height: 9),

        InputCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.cardBorder,
                  ),
                ),
                child: TextField(
                  controller: answerController,
                  maxLines: 5,
                  maxLength: 1000,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText:
                    'Write a clear explanation that helps '
                        'the reader understand the answer...',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppColors.textMuted,
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.cardBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.3,
                      ),
                    ),
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(
                    Icons.tips_and_updates_outlined,
                    size: 15,
                    color: AppColors.textMuted,
                  ),

                  const SizedBox(width: 6),

                  const Expanded(
                    child: Text(
                      'Add examples or key points when useful.',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),

                  Text(
                    '${answerController.text.length}/1000',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),
        GradientButton(
          label: 'Publish Question',
          icon: Icons.arrow_upward_rounded,
          onPressed: () {},
        ),

        const SizedBox(height: 10),

        const Center(
          child: Text(
            'Your question will be visible to everyone in this track.',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

class TopicDropDownButton extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const TopicDropDownButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBorder,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          items: const [
            DropdownMenuItem(
              value: 'General',
              child: Text('General'),
            ),
            DropdownMenuItem(
              value: 'Basics',
              child: Text('Basics'),
            ),
            DropdownMenuItem(
              value: 'Advanced',
              child: Text('Advanced'),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}