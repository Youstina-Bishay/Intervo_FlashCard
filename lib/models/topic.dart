/// A topic within a track, e.g. "REST API" under the Backend track.
/// Progress is tracked locally in memory via [studiedCards].
class Topic {
  final String id;
  final String trackId;
  final String name;
  final String iconKey;
  final int totalCards;
  final int studiedCards;

  const Topic({
    required this.id,
    required this.trackId,
    required this.name,
    required this.iconKey,
    required this.totalCards,
    required this.studiedCards,
  });

  double get progress => totalCards == 0 ? 0 : studiedCards / totalCards;
  int get progressPercent => (progress * 100).round();

  Topic copyWith({int? studiedCards}) {
    return Topic(
      id: id,
      trackId: trackId,
      name: name,
      iconKey: iconKey,
      totalCards: totalCards,
      studiedCards: studiedCards ?? this.studiedCards,
    );
  }
}
