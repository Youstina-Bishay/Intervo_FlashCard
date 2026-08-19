import 'package:intervo/models/topic.dart';
import 'package:intervo/models/track.dart';

import '../../models/question.dart';

abstract class HomeRepo{
  Future<List<Track>> getAllTracks();
  Future<List<Topic>> getAllTopics(String track);
  Future<List<Question>> getQuestions(
      String trackId,
      String topicName,
      );
}