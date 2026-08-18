class Track {
  final String id;
  final String name;
  final String description;
  final int totalQuestions;

  const Track({
    required this.id,
    required this.name,
    required this.description,
    required this.totalQuestions,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,
    );
  }
}