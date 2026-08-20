import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/presentation/cubit/addQuestionCubit.dart';
import 'package:intervo/presentation/cubit/addQuestionState.dart';
import 'package:intervo/presentation/screens/add_flashcard/sectionLabel.dart';

import '../../../core/widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/models/topic.dart';
import '../../../domain/models/track.dart';
import '../../../domain/models/trackUI.dart';
import 'inputCard.dart';

class AddQuestionForm extends StatefulWidget {
  final Track track;
  final TrackUI trackUI;
  final List<Topic> topics;

  const AddQuestionForm({
    super.key,
    required this.track,
    required this.trackUI,
    required this.topics,
  });

  @override
  State<AddQuestionForm> createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  String? selectedTopic;

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  void _clearForm() {
    questionController.clear();
    answerController.clear();

    setState(() {
      selectedTopic = null;
    });
  }

  void _publishQuestion() {
    FocusScope.of(context).unfocus();
    if (selectedTopic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a topic first.',
          ),
        ),
      );
      return;
    }
    final question = questionController.text.trim();
    final answer = answerController.text.trim();

    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a question.',
          ),
        ),
      );
      return;
    }

    if (question.length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Question must be 100 characters or less.',
          ),
        ),
      );
      return;
    }

    if (answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter an answer.',
          ),
        ),
      );
      return;
    }

    context.read<AddQuestionCubit>().addQuestion(
      trackId: widget.track.id,
      topicName: selectedTopic!,
      question: question,
      answer: answer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final track = widget.track;
    final trackUI = widget.trackUI;

    return BlocConsumer<AddQuestionCubit, AddQuestionState>(
      listener: (context, state) {
        if (state.status == AddQuestionStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Question published successfully! 🎉',
              ),
              duration: Duration(seconds: 3),
            ),
          );

          _clearForm();
        }

        if (state.status == AddQuestionStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ??
                    'Something went wrong. Please try again.',
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },

      builder: (context, state) {
        final isLoading =
            state.status == AddQuestionStatus.loading;

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
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                      color:
                      AppColors.success.withOpacity(.10),
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
              topics: widget.topics,
              value: selectedTopic,
              onChanged: isLoading
                  ? null
                  : (value) {
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
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius:
                      BorderRadius.circular(14),
                      border: Border.all(
                        color:
                        questionController.text.length >
                            100
                            ? Colors.red
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: TextField(
                      controller: questionController,
                      maxLines: 4,
                      maxLength: 100,
                      enabled: !isLoading,

                      onChanged: (_) {
                        setState(() {});
                      },

                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),

                      decoration: InputDecoration(
                        hintText:
                        'e.g. What is the difference between let, const and var?',

                        hintStyle: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.textMuted,
                        ),

                        filled: true,
                        fillColor: AppColors.background,

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.cardBorder,
                          ),
                        ),

                        focusedBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.3,
                          ),
                        ),

                        counterText: '',

                        contentPadding:
                        const EdgeInsets.symmetric(
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
                        Icons.info_outline_rounded,
                        size: 15,
                        color: AppColors.textMuted,
                      ),

                      const SizedBox(width: 6),

                      const Expanded(
                        child: Text(
                          'Keep the question short and interview-focused.',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),

                      Text(
                        '${questionController.text.length}/100',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                          questionController.text.length >=
                              90
                              ? Colors.red
                              : AppColors.textMuted,
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
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius:
                      BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.cardBorder,
                      ),
                    ),
                    child: TextField(
                      controller: answerController,

                      maxLines: 8,
                      maxLength: 1000,

                      enabled: !isLoading,

                      keyboardType:
                      TextInputType.multiline,

                      onChanged: (_) {
                        setState(() {});
                      },

                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),

                      decoration: InputDecoration(

                        hintText:
                        'Write a clear explanation that helps the reader understand the answer...\n\nYou can also include a useful reference link if needed.',

                        hintStyle: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.textMuted,
                        ),

                        filled: true,
                        fillColor: AppColors.background,

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.cardBorder,
                          ),
                        ),

                        focusedBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.3,
                          ),
                        ),

                        counterText: '',

                        contentPadding:
                        const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      const Icon(
                        Icons.tips_and_updates_outlined,
                        size: 15,
                        color: AppColors.textMuted,
                      ),

                      const SizedBox(width: 6),

                      const Expanded(
                        child: Text(
                          'Add examples, key points, or a useful reference link when needed.',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

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
              label: isLoading
                  ? 'Publishing...'
                  : 'Publish Question',

              icon: isLoading
                  ? Icons.hourglass_top_rounded
                  : Icons.arrow_upward_rounded,

              onPressed:
              isLoading ? null : _publishQuestion,
            ),

            const SizedBox(height: 10),

            const Center(
              child: Text(
                'Your question will be visible to everyone in this track.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TopicDropDownButton extends StatelessWidget {
  final List<Topic> topics;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const TopicDropDownButton({
    super.key,
    required this.topics,
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

          hint: const Text(
            'Select a topic',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),

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

          items: topics.map((topic) {
            return DropdownMenuItem<String>(
              value: topic.name,
              child: Text(
                topic.name,
              ),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}