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

  final questionController = TextEditingController();
  final answerController = TextEditingController();

  AddFlashcardProvider({required this.initialTrackId}) {
    questionController.addListener(notifyListeners);
    answerController.addListener(notifyListeners);
  }



  String get initialTrackName =>
      MockData.tracks.firstWhere((t) => t.id == initialTrackId).name;

  void selectTrack(String trackId) {
    selectedTrackId = trackId;
    notifyListeners();
  }

  void selectTopic(Topic topic) {
    notifyListeners();
  }

  bool get canSave =>
      questionController.text.trim().isNotEmpty &&
      answerController.text.trim().isNotEmpty;

  /// Returns the id of the topic the card was saved under, or null if the
  /// form wasn't valid.


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
