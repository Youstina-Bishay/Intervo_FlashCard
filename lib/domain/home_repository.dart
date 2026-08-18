import 'package:intervo/models/track.dart';

abstract class HomeRepo{
  Future<List<Track>> getAllTracks();
}