class Question {
  final String question;
  final String answer;

  Question({
    required this.question,
    required this.answer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['Q'] ?? '',
      answer: map['A'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Q': question,
      'A': answer,
    };
  }
}