import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/flashcard.dart';

/// Drives the flashcard study flow: which card is showing, whether the
/// answer side is flipped up, and next/previous/delete/bookmark actions.
/// All state lives in memory — mutating [MockData.flashcards] directly.
class StudyProvider extends ChangeNotifier {
  final String topicId;

  StudyProvider({required this.topicId}) {
    _refreshCards();
  }

  List<Flashcard> cards = [];
  int currentIndex = 0;
  bool showAnswer = false;

  void _refreshCards() {
    cards = MockData.flashcards.where((c) => c.topicId == topicId).toList();
  }

  Flashcard? get currentCard =>
      cards.isEmpty ? null : cards[currentIndex.clamp(0, cards.length - 1)];

  int get progressCount => cards.isEmpty ? 0 : currentIndex + 1;
  double get progressRatio => cards.isEmpty ? 0 : progressCount / cards.length;
  int get progressPercent => (progressRatio * 100).round();

  void toggleAnswer() {
    showAnswer = !showAnswer;
    notifyListeners();
  }

  /// Re-reads cards from [MockData] — call after another screen (like Add
  /// Flashcard) has mutated the shared in-memory list.
  void refresh() {
    _refreshCards();
    notifyListeners();
  }

  void next() {
    if (currentIndex < cards.length - 1) {
      currentIndex++;
      showAnswer = false;
      notifyListeners();
    }
  }

  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      showAnswer = false;
      notifyListeners();
    }
  }

  void toggleBookmark() {
    final card = currentCard;
    if (card == null) return;
    final updated = card.copyWith(isBookmarked: !card.isBookmarked);
    final globalIndex = MockData.flashcards.indexWhere((c) => c.id == card.id);
    if (globalIndex != -1) MockData.flashcards[globalIndex] = updated;
    _refreshCards();
    notifyListeners();
  }

  void deleteCurrentCard() {
    final card = currentCard;
    if (card == null) return;
    MockData.flashcards.removeWhere((c) => c.id == card.id);
    _refreshCards();
    if (currentIndex >= cards.length && currentIndex > 0) {
      currentIndex = cards.length - 1;
    }
    showAnswer = false;
    notifyListeners();
  }
}
