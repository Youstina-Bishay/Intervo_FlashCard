import '../models/question.dart';
import '../models/topic.dart';
import '../models/track.dart';

abstract class HomeRepo{
  Future<List<Track>> getAllTracks();
  Future<List<Topic>> getAllTopics(String track);
  Future<List<Question>> getQuestions(
      String trackId,
      String topicName,
      );

  Future<void> addQuestion(
      String trackId,
      String topicName,
      Question question,
      );
}