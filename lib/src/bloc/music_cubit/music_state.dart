part of 'music_cubit.dart';

class MusicCubitState {
  final List<MusicEntity> music;
  final CubitState state;
  final String erroreMessage;
  final int currentIndex;

  MusicCubitState({
    this.music = const [],
    this.state = CubitState.initial,
    this.erroreMessage = '',
    this.currentIndex = 0,
  });

  List<Object> get props => [
        music,
        state,
        erroreMessage,
        currentIndex,
      ];

  MusicCubitState copyWith({
    List<MusicEntity>? music,
    CubitState? state,
    String? erroreMessage,
    int? currentIndex,
  }) {
    return MusicCubitState(
      music: music ?? this.music,
      state: state ?? this.state,
      erroreMessage: erroreMessage ?? this.erroreMessage,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
