import 'package:intervo/models/topic.dart';

import '../../models/question.dart';
import '../../models/track.dart';

abstract class HomeRemoteDataSource{
  Future<List<Track>> getAllTracks();
  Future<List<Topic>> getAllTopics(String track);
  Future<List<Question>> getQuestions(String trackId ,String topicName);
}