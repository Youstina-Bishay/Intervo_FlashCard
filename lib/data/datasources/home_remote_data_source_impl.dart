import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intervo/core/constants/firebase_constants.dart';
import 'package:intervo/models/topic.dart';
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
  @override
  Future<List<Topic>> getAllTopics(String track) async {
    final snapshot = await firestore
        .collection(FirebaseConstants.tracks)
        .doc(track)
        .get();
    final data = snapshot.data();
    if (data == null) {
      return [];
    }
    final topicsMap = data['topics'] as Map<String, dynamic>?;
    if (topicsMap == null) {
      return [];
    }
    return topicsMap.keys.map((topicName) {
      return Topic(name: topicName, questions: const []);
    }).toList();
  }

}