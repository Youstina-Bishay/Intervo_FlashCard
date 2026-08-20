import 'question.dart';

class Topic {
  final String name;
  final List<Question> questions;

  Topic({
    required this.name,
    required this.questions,
  });

  factory Topic.fromMap(
      String name,
      List<dynamic> questions,
      ) {
    return Topic(
      name: name,
      questions: questions
          .map(
            (question) => Question.fromMap(
          Map<String, dynamic>.from(question),
        ),
      )
          .toList(),
    );
  }
}