import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/domain/repositories/home_repository.dart';

import '../../domain/models/question.dart';
import 'addQuestionState.dart';

class AddQuestionCubit extends Cubit<AddQuestionState> {
  final HomeRepo repo;

  AddQuestionCubit({
    required this.repo,
  }) : super(const AddQuestionState());

  Future<void> addQuestion({
    required String trackId,
    required String topicName,
    required String question,
    required String answer,
  }) async {
    emit(
      state.copyWith(
        status: AddQuestionStatus.loading,
      ),
    );

    try {
      final newQuestion = Question(
        question: question.trim(),
        answer: answer.trim(),
      );

      await repo.addQuestion(
        trackId,
        topicName,
        newQuestion,
      );

      emit(
        state.copyWith(
          status: AddQuestionStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddQuestionStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}