/// A top-level learning track, e.g. "Frontend" or "Backend".
/// Plain UI model — holds no persistence or networking logic.
class Track {
  final String id;
  final String name;
  final String description;
  final int totalQuestions;
  final String iconKey;

  const Track({
    required this.id,
    required this.name,
    required this.description,
    required this.totalQuestions,
    required this.iconKey,
  });
}
