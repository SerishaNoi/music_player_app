import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/src/bloc/music_cubit/cubit_state.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_state_enum.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerCubitState> {
  final AudioPlayer musicPlayer;

  PlayerCubit({
    required this.musicPlayer,
  }) : super(const PlayerCubitState());

  StreamSubscription? playerController;

  void loadTrack(String url) async {
    try {
      emit(state.copyWith(playerState: MusicPlayerState.loading));
      await musicPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
        ),
        initialPosition: Duration.zero,
        preload: true,
      );
      emit(state.copyWith(playerState: MusicPlayerState.loaded));
      await _setMusicPlayer();
      await musicPlayer.play();
    } catch (e) {
      throw Exception('Something got wrong');
    }
  }

  unloadTrack() {
    musicPlayer.stop();
    if (playerController != null) {
      playerController!.cancel();
    }
    emit(state.copyWith(playerState: MusicPlayerState.initial));
  }

  _setMusicPlayer() async {
    playerController = musicPlayer.playerStateStream.listen(
      (playerState) {
        if (playerState.processingState == ProcessingState.loading ||
            playerState.processingState == ProcessingState.buffering) {
          emit(state.copyWith(playerState: MusicPlayerState.loading));
        } else if (!playerState.playing) {
          emit(state.copyWith(playerState: MusicPlayerState.paused));
        } else if (playerState.processingState != ProcessingState.completed) {
          emit(state.copyWith(playerState: MusicPlayerState.playing));
        } else {
          musicPlayer.seek(Duration.zero);
          musicPlayer.pause();
        }
      },
    );

    musicPlayer.positionStream.listen((position) {
      emit(state.copyWith(position: position));
    });

    musicPlayer.bufferedPositionStream.listen((streamPosition) {
      emit(state.copyWith(streamPosition: streamPosition));
    });

    musicPlayer.durationStream.listen((totoalTrackLenght) {
      emit(state.copyWith(totoalTrackLenght: totoalTrackLenght));
    });
  }
}
