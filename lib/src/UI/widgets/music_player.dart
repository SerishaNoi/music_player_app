import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/src/bloc/music_cubit/cubit_state.dart';
import 'package:music_player_app/src/bloc/music_cubit/music_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_state_enum.dart';
import 'package:music_player_app/src/injections/get_it.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({
    Key? key,
  }) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = getItInstance<AudioPlayer>();
    final MusicCubit musicCubit = context.watch<MusicCubit>();

    return BlocBuilder<PlayerCubit, PlayerCubitState>(
      builder: (context, state) {
        if (state.playerState == MusicPlayerState.loaded ||
            state.playerState == MusicPlayerState.playing ||
            state.playerState == MusicPlayerState.paused) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 188, 188, 188),
                  Color.fromARGB(255, 253, 253, 253),
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.14,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          audioPlayer.seekToPrevious();
                        },
                        icon: const Icon(
                          Icons.keyboard_double_arrow_left_outlined,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 30),
                      !audioPlayer.playing
                          ? IconButton(
                              key: const ValueKey('playButton'),
                              onPressed: () {
                                audioPlayer.play();
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                size: 40.0,
                              ),
                            )
                          : IconButton(
                              key: const ValueKey('pauseButton'),
                              onPressed: () {
                                audioPlayer.pause();
                              },
                              icon: const Icon(
                                Icons.pause,
                                size: 40.0,
                              ),
                            ),
                      const SizedBox(width: 30),
                      IconButton(
                        onPressed: () {
                          audioPlayer.seekToNext();
                        },
                        icon: const Icon(
                          Icons.keyboard_double_arrow_right_outlined,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ProgressBar(
                    baseBarColor: Colors.black87,
                    bufferedBarColor: Colors.red,
                    progressBarColor: Colors.blueGrey,
                    thumbColor: Colors.white,
                    thumbGlowColor: Colors.black87,
                    thumbGlowRadius: 10,
                    progress: state.position,
                    buffered: state.streamPosition,
                    total: state.totoalTrackLenght,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
