import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intervo/core/constants/firebase_constants.dart';
import 'package:intervo/models/track.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({
    required this.firestore,
  });

  @override
  Future<List<Track>> getAllTracks() async {
    final snapshot = await firestore
        .collection(FirebaseConstants.tracks)
        .get();


    return snapshot.docs.map((doc) {
      return Track.fromJson({
        'id': doc.id,
        ...doc.data(),
      });
    }).toList();
  }
}