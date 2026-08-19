import 'package:intervo/data/datasources/home_remote_data_source.dart';
import 'package:intervo/models/question.dart';
import 'package:intervo/models/topic.dart';
import 'package:intervo/models/track.dart';

import '../../domain/repositories/home_repository.dart';

class HomeRepoImpl implements HomeRepo{
  final HomeRemoteDataSource dataSource;
HomeRepoImpl({required this.dataSource});
  @override
  Future<List<Track>> getAllTracks() async{
    final tracks= await dataSource.getAllTracks();
    return tracks;
  }

  @override
  Future<List<Topic>> getAllTopics(String track)async {
  final topics = await dataSource.getAllTopics(track);
  return topics;
  }

  @override
  Future<List<Question>> getQuestions(String trackId, String topicName)async {
   final questions = await dataSource.getQuestions(trackId, topicName);
   return questions;
  }

}