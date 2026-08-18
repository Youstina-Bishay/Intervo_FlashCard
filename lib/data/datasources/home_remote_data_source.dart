import '../../models/track.dart';

abstract class HomeRemoteDataSource{
  Future<List<Track>> getAllTracks();
}