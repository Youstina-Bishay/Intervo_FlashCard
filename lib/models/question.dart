class Question {
  final String question;
  final String answer;

  Question({
    required this.question,
    required this.answer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}