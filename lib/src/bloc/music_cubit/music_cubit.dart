import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/src/API/domain/get_music.dart';

import 'package:music_player_app/src/API/models/music_entity.dart';
import 'package:music_player_app/src/bloc/music_cubit/cubit_state.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicCubitState> {
  final GetMusic getMusic;
  final String _defaultQuery = '';

  MusicCubit({
    required this.getMusic,
  }) : super(MusicCubitState()) {
    loadMusic(query: _defaultQuery);
  }

  loadMusic({required String query}) async {
    emit(state.copyWith(state: CubitState.loading));

    final data = await getMusic.getMusic(
      GetMusicParams(searchText: query.isEmpty ? _defaultQuery : query),
    );

    if (data.isNotEmpty) {
      emit(
        state.copyWith(
          music: data,
          state: CubitState.loaded,
        ),
      );
    }
    if (data.isEmpty) {
      emit(
        state.copyWith(
          erroreMessage: 'Something got wrong',
          state: CubitState.failure,
        ),
      );
    }
  }

  String selectedMusic(int index) {
    emit(state.copyWith(currentIndex: index));
    return state.music[index].previewUrl;
  }
}
