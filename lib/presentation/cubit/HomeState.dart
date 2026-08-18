import 'package:intervo/models/track.dart';

enum Status {initial , loading , success , error}

class HomeState{
  final Status status;
  final List<Track>? tracks ;
  final String? errorMsg ;

  const HomeState({
    this.status=Status.initial ,
    this.tracks,
    this.errorMsg
});
  HomeState copyWith({
    Status? status,
    List<Track>? tracks,
    String? errorMsg,
  }) {
    return HomeState(
      status: status ?? this.status,
      tracks: tracks ?? this.tracks,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}