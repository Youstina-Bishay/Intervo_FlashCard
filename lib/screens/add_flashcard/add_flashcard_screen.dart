import 'package:flutter/material.dart';
import 'package:intervo/screens/add_flashcard/trackSelection.dart';
import '../../theme/app_colors.dart';
import 'addQuestionForm.dart';

class AddFlashcardScreen extends StatefulWidget {
  const AddFlashcardScreen({super.key});

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  bool showForm = false;

  int selectedTrackIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,

        leading: showForm
            ? IconButton(
          onPressed: () {
            setState(() {
              showForm = false;
            });
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.textPrimary,
          ),
        )
            : null,

        title: Text(
          showForm ? 'Add Interview Question' : 'Choose Your Track',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: showForm
            ? AddQuestionForm(
          key: const ValueKey('form'),
          trackIndex: selectedTrackIndex,
        )
            : TrackSelection(
          key: const ValueKey('tracks'),
          onTrackSelected: (index) {
            setState(() {
              selectedTrackIndex = index;
              showForm = true;
            });
          },
        ),
      ),
    );
  }
}



