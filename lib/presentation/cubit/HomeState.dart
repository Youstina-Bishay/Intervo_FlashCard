import '../../domain/models/topic.dart';
import '../../domain/models/track.dart';

enum Status {
  initial,
  loading,
  success,
  error,
}

class HomeState {
  final Status status;
  final List<Track> tracks;
  final List<Topic> topics;
  final String? errorMessage;

  const HomeState({
    this.status = Status.initial,
    this.tracks = const [],
    this.topics = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    Status? status,
    List<Track>? tracks,
    List<Topic>? topics,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      tracks: tracks ?? this.tracks,
      topics: topics ?? this.topics,
      errorMessage: errorMessage,
    );
  }


}