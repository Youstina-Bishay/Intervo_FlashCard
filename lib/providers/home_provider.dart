import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/topic.dart';
import '../models/track.dart';
import '../models/user_stats.dart';

/// Home-screen state. Reads straight from [MockData] — no network calls,
/// no async loading, since this is a UI-only build.
class HomeProvider extends ChangeNotifier {
  List<Track> get tracks => MockData.tracks;
}
