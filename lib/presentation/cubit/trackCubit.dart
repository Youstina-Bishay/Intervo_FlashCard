import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/domain/repositories/home_repository.dart';
import 'package:intervo/presentation/cubit/trackState.dart';


class TrackCubit extends Cubit<TrackState> {
  final HomeRepo repository;

  TrackCubit({
    required this.repository,
  }) : super(const TrackState());

  Future<void> getTopics(String trackId) async {
    emit(
      state.copyWith(
        status: TrackStatus.loading,
      ),
    );

    try {
      final topics = await repository.getAllTopics(trackId);

      emit(
        state.copyWith(
          status: TrackStatus.success,
          topics: topics,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TrackStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}