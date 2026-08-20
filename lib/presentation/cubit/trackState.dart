
import '../../domain/models/topic.dart';

enum TrackStatus {
  initial,
  loading,
  success,
  error,
}



class TrackState  {
  final TrackStatus status;
  final List<Topic> topics;
  final String? errorMessage;

  const TrackState({
    this.status = TrackStatus.initial,
    this.topics = const [],
    this.errorMessage,
  });

  TrackState copyWith({
    TrackStatus? status,
    List<Topic>? topics,
    String? errorMessage,
  }) {
    return TrackState(
      status: status ?? this.status,
      topics: topics ?? this.topics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

}