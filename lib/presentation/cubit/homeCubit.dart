import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intervo/domain/home_repository.dart';
import 'package:intervo/presentation/cubit/HomeState.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;

  HomeCubit({required this.repo}) : super(const HomeState());

  Future<void> getAllTracks() async {
    emit(
        state.copyWith(status: Status.loading)
    );

    try {
      final tracks = await repo.getAllTracks();
      if (tracks.isNotEmpty) {
        emit(state.copyWith(
          status: Status.success,
          tracks: tracks,
        ),
        );
      }
    }catch(e){
      emit(state.copyWith(status: Status.error,
      errorMsg: e.toString()
      ));
    }
  }
}

