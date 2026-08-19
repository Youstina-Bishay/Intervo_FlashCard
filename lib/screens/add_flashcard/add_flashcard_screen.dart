import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/data/datasources/home_remote_data_source_impl.dart';
import 'package:intervo/data/repositories/home_repository_impl.dart';
import 'package:intervo/models/track.dart';
import 'package:intervo/presentation/cubit/HomeState.dart';
import 'package:intervo/presentation/cubit/homeCubit.dart';
import 'package:intervo/screens/add_flashcard/trackSelection.dart';

import '../../models/trackUI.dart';
import '../../theme/app_colors.dart';
import 'addQuestionForm.dart';

class AddFlashcardScreen extends StatelessWidget {
  const AddFlashcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    final homeRemoteDataSource = HomeRemoteDataSourceImpl(
      firestore: firestore,
    );

    final repo = HomeRepoImpl(
      dataSource: homeRemoteDataSource,
    );

    return BlocProvider(
      create: (_) => HomeCubit(repo: repo)..getAllTracks(),
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
              track: selectedTrack!,
              trackUI: selectedTrackUI!,
            )
                : TrackSelection(
              key: const ValueKey('tracks'),
              onTrackSelected: (track, trackUI) {
                setState(() {
                  selectedTrack = track;
                  selectedTrackUI = trackUI;
                  showForm = true;
                });
              },
              tracks: tracks,
              tracksUI: tracksUI,
            ),
          ),
        );
      },
    );
  }
}