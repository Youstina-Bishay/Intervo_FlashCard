

import '../../domain/models/question.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/track.dart';

abstract class HomeRemoteDataSource{
  Future<List<Track>> getAllTracks();
  Future<List<Topic>> getAllTopics(String track);
  Future<List<Question>> getQuestions(String trackId ,String topicName);
  Future<void> addQuestion(
      String trackId,
      String topicName,
      Question question,
      );
}