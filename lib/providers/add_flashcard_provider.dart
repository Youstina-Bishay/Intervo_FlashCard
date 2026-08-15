import 'package:flutter/widgets.dart';

import '../data/mock_data.dart';
import '../models/flashcard.dart';
import '../models/topic.dart';

/// Form state for the "Add Flashcard" screen: track segment (current track
/// vs "General"), topic dropdown, and the question/answer text fields.
/// Saving just appends to the in-memory [MockData.flashcards] list.
class AddFlashcardProvider extends ChangeNotifier {
  static const int questionMaxLength = 250;
  static const int answerMaxLength = 1000;

  final String initialTrackId;
  late String selectedTrackId = initialTrackId;
  late Topic? selectedTopic = _topicsForTrack(initialTrackId).firstOrNull;

  final questionController = TextEditingController();
  final answerController = TextEditingController();

  AddFlashcardProvider({required this.initialTrackId}) {
    questionController.addListener(notifyListeners);
    answerController.addListener(notifyListeners);
  }

  List<Topic> get topicsForSelectedTrack => _topicsForTrack(selectedTrackId);

  List<Topic> _topicsForTrack(String trackId) =>
      MockData.topics.where((t) => t.trackId == trackId).toList();

  String get initialTrackName =>
      MockData.tracks.firstWhere((t) => t.id == initialTrackId).name;

  void selectTrack(String trackId) {
    selectedTrackId = trackId;
    selectedTopic = _topicsForTrack(trackId).firstOrNull;
    notifyListeners();
  }

  void selectTopic(Topic topic) {
    selectedTopic = topic;
    notifyListeners();
  }

  bool get canSave =>
      selectedTopic != null &&
      questionController.text.trim().isNotEmpty &&
      answerController.text.trim().isNotEmpty;

  /// Returns the id of the topic the card was saved under, or null if the
  /// form wasn't valid.
  String? save() {
    if (!canSave) return null;
    final topicId = selectedTopic!.id;
    MockData.flashcards.add(Flashcard(
      id: 'card_${DateTime.now().microsecondsSinceEpoch}',
      topicId: topicId,
      question: questionController.text.trim(),
      answer: answerController.text.trim(),
    ));
    return topicId;
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }
}

/// Tiny helper so `.firstOrNull` reads cleanly without adding the
/// `collection` package as a dependency for one call site.
extension _FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
