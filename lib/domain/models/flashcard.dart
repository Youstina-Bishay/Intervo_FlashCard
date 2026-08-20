/// A single flashcard (question/answer pair). Lives only in memory for
/// this UI-only build — see [MockData] for the seed list.
class Flashcard {
  final String id;
  final String topicId;
  final String question;
  final String answer;
  final bool isBookmarked;
  final bool isStudied;

  const Flashcard({
    required this.id,
    required this.topicId,
    required this.question,
    required this.answer,
    this.isBookmarked = false,
    this.isStudied = false,
  });

  Flashcard copyWith({bool? isBookmarked, bool? isStudied}) {
    return Flashcard(
      id: id,
      topicId: topicId,
      question: question,
      answer: answer,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isStudied: isStudied ?? this.isStudied,
    );
  }
}
