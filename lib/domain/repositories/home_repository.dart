import 'package:intervo/models/topic.dart';
import 'package:intervo/models/track.dart';

abstract class HomeRepo{
  Future<List<Track>> getAllTracks();
  Future<List<Topic>> getAllTopics(String track);
}