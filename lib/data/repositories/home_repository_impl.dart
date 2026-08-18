import 'package:intervo/data/datasources/home_remote_data_source.dart';
import 'package:intervo/models/track.dart';

import '../../domain/home_repository.dart';

class HomeRepoImpl implements HomeRepo{
  final HomeRemoteDataSource dataSource;
HomeRepoImpl({required this.dataSource});
  @override
  Future<List<Track>> getAllTracks() async{
    final tracks= await dataSource.getAllTracks();
    return tracks;
  }

}