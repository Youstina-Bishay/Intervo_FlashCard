class TopicProgress {
  final String topicId;
  final int studiedCards;

  const TopicProgress({
    required this.topicId,
    required this.studiedCards,
  });

  TopicProgress copyWith({
    int? studiedCards,
  }) {
    return TopicProgress(
      topicId: topicId,
      studiedCards: studiedCards ?? this.studiedCards,
    );
  }

  double progress(int totalCards) {
    if (totalCards == 0) return 0;
    return studiedCards / totalCards;
  }

  int progressPercent(int totalCards) {
    return (progress(totalCards) * 100).round();
  }
}