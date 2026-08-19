import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/domain/repositories/home_repository.dart';
import 'package:intervo/presentation/cubit/topicState.dart';

class TopicCubit extends Cubit<TopicState> {
  final HomeRepo repo;

  TopicCubit({required this.repo}) : super(const TopicState());

  Future<void> getAllQuestions(String trackId , String topicName) async {
    emit(
        state.copyWith(status: TopicStatus.loading)
    );

    try {
      final questions = await repo.getQuestions(trackId, topicName);
      if (questions.isNotEmpty) {
        emit(state.copyWith(
          status: TopicStatus.success,
          questions: questions
        ),
        );
      }
    }catch(e){
      emit(state.copyWith(status: TopicStatus.error,
          errorMessage: e.toString()
      ));
    }
  }
}

