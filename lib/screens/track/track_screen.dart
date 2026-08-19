import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/core/di/injection.dart';
import '../../presentation/cubit/trackCubit.dart';
import 'TrackView.dart';

class TrackScreen extends StatelessWidget {
  final String trackId;
  final String trackName;
  final String image;
  final Color color;

  const TrackScreen({
    super.key,
    required this.trackId,
    required this.trackName,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
  final repo=createHomeRepo();
    return BlocProvider(
      create: (context) => TrackCubit(
        repository:repo,
      )..getTopics(trackId),
      child: TrackView(
        trackId: trackId,
        trackName: trackName,
        image: image,
        color: color,
      ),
    );  }
}