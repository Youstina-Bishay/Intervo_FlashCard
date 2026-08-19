
import 'package:intervo/models/question.dart';
enum TopicStatus {
  initial,
  loading,
  success,
  error,
}



class TopicState  {
  final TopicStatus status;
  final List<Question> questions;
  final String? errorMessage;

  const TopicState({
    this.status = TopicStatus.initial,
    this.questions = const [],
    this.errorMessage,
  });

  TopicState copyWith({
    TopicStatus? status,
    List<Question>? questions,
    String? errorMessage,
  }) {
    return TopicState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

}