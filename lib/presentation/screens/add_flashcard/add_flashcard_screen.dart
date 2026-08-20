import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/core/di/injection.dart';
import 'package:intervo/presentation/cubit/HomeState.dart';
import 'package:intervo/presentation/cubit/homeCubit.dart';
import 'package:intervo/presentation/cubit/addQuestionCubit.dart';
import 'package:intervo/presentation/screens/add_flashcard/trackSelection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/models/track.dart';
import '../../../domain/models/trackUI.dart';
import 'addQuestionForm.dart';

class AddFlashcardScreen extends StatelessWidget {
  const AddFlashcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo =createHomeRepo();

    return MultiBlocProvider(
      providers: [
        // Home Cubit
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            repo: repo,
          )..getAllTracks(),
        ),

        // Add Question Cubit
        BlocProvider<AddQuestionCubit>(
          create: (_) => AddQuestionCubit(
            repo: repo,
          ),
        ),
      ],
      child: const _AddFlashcardView(),
    );
  }
}

class _AddFlashcardView extends StatefulWidget {
  const _AddFlashcardView();

  @override
  State<_AddFlashcardView> createState() => _AddFlashcardViewState();
}

class _AddFlashcardViewState extends State<_AddFlashcardView> {
  bool showForm = false;

  Track? selectedTrack;
  TrackUI? selectedTrackUI;

  Future<void> _selectTrack(
      Track track,
      TrackUI trackUI,
      ) async {
    // Save selected track
    setState(() {
      selectedTrack = track;
      selectedTrackUI = trackUI;
    });

    // Get topics of selected track
    await context.read<HomeCubit>().getAllTopics(
      track.id,
    );

    if (!mounted) return;

    final state = context.read<HomeCubit>().state;

    // Check if track has topics
    if (state.topics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No topics found for this track.',
          ),
        ),
      );

      return;
    }

    // Open question form
    setState(() {
      showForm = true;
    });
  }

  void _goBackToTracks() {
    setState(() {
      showForm = false;
      selectedTrack = null;
      selectedTrackUI = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final tracks = state.tracks ?? [];

        final tracksUI = tracks.map((track) {
          return getTrackUI(track.id);
        }).toList();

        return Scaffold(
          backgroundColor: const Color(0xfff3f1f9),
          appBar: AppBar(
            backgroundColor: const Color(0xfff3f1f9),
            elevation: 0,
            centerTitle: false,

            leading: showForm
                ? IconButton(
              onPressed: _goBackToTracks,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: AppColors.textPrimary,
              ),
            )
                : null,

            title: Text(
              showForm
                  ? 'Add Interview Question'
                  : 'Choose Your Track',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          body: AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 450,
            ),

            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,

            transitionBuilder: (
                child,
                animation,
                ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },

            child: showForm
                ? AddQuestionForm(
              key: const ValueKey('form'),

              track: selectedTrack!,
              trackUI: selectedTrackUI!,

              // Topics الخاصة بالـ Track المختار
              topics: state.topics,
            )
                : TrackSelection(
              key: const ValueKey('tracks'),

              onTrackSelected: _selectTrack,

              tracks: tracks,
              tracksUI: tracksUI,
            ),
          ),
        );
      },
    );
  }
}