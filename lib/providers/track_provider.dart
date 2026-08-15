import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/topic.dart';

/// Topics list + progress for a single track, read from [MockData].
class TrackProvider extends ChangeNotifier {
  final String trackId;

  TrackProvider({required this.trackId});

  List<Topic> get topics =>
      MockData.topics.where((t) => t.trackId == trackId).toList();

  /// Overall track progress across all its topics, 0.0–1.0.
  double get overallProgress {
    final list = topics;
    if (list.isEmpty) return 0;
    final totalCards = list.fold<int>(0, (sum, t) => sum + t.totalCards);
    final studied = list.fold<int>(0, (sum, t) => sum + t.studiedCards);
    if (totalCards == 0) return 0;
    return studied / totalCards;
  }
}
