import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intervo/core/constants/firebase_constants.dart';
import '../../domain/models/question.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/track.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({
    required this.firestore,
  });

  @override
  Future<List<Track>> getAllTracks() async {
    final snapshot = await firestore.collection(FirebaseConstants.tracks).get();

    return snapshot.docs.map((doc) {
      return Track.fromJson({
        'id': doc.id,
        ...doc.data(),
      });
    }).toList();
  }

  @override
  Future<List<Topic>> getAllTopics(String track) async {
    final snapshot =
        await firestore.collection(FirebaseConstants.tracks).doc(track).get();
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

  @override
  Future<List<Question>> getQuestions(
    String trackId,
    String topicName,
  ) async {
    final snapshot =
        await firestore.collection(FirebaseConstants.tracks).doc(trackId).get();

    final data = snapshot.data();

    if (data == null) {
      return [];
    }

    final topicsMap = data['topics'] as Map<String, dynamic>?;

    if (topicsMap == null) {
      return [];
    }

    final questionsData = topicsMap[topicName];

    if (questionsData == null) {
      return [];
    }

    return List<dynamic>.from(questionsData)
        .map(
          (question) => Question.fromMap(
            Map<String, dynamic>.from(question),
          ),
        )
        .toList();
  }

  @override
  Future<void> addQuestion(
      String trackId,
      String topicName,
      Question question,
      ) async {
    final docRef = firestore
        .collection(FirebaseConstants.tracks)
        .doc(trackId);

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      throw Exception('Track not found');
    }

    final data = snapshot.data();

    if (data == null) {
      throw Exception('Track data not found');
    }

    final topicsMap = Map<String, dynamic>.from(
      data['topics'] ?? {},
    );

    final existingQuestions = List<dynamic>.from(
      topicsMap[topicName] ?? [],
    );

    existingQuestions.add(question.toMap());

    topicsMap[topicName] = existingQuestions;

    await docRef.update({
      'topics': topicsMap,
    });
  }
}
