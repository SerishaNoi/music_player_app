part of 'player_cubit.dart';

class PlayerCubitState {
  final CubitState cubitState;
  final MusicPlayerState playerState;
  final Duration streamPosition;
  final Duration totoalTrackLenght;
  final Duration position;
  final String erroreMessage;

  const PlayerCubitState({
    this.cubitState = CubitState.initial,
    this.playerState = MusicPlayerState.initial,
    this.streamPosition = const Duration(minutes: 0),
    this.totoalTrackLenght = const Duration(minutes: 0),
    this.position = const Duration(minutes: 0),
    this.erroreMessage = '',
  });

  List<Object?> get props => [
        cubitState,
        playerState,
        streamPosition,
        position,
        erroreMessage,
      ];

  PlayerCubitState copyWith({
    CubitState? cubitState,
    MusicPlayerState? playerState,
    Duration? streamPosition,
    Duration? totoalTrackLenght,
    Duration? position,
    String? erroreMessage,
  }) {
    return PlayerCubitState(
      cubitState: cubitState ?? this.cubitState,
      playerState: playerState ?? this.playerState,
      streamPosition: streamPosition ?? this.streamPosition,
      totoalTrackLenght: totoalTrackLenght ?? this.totoalTrackLenght,
      position: position ?? this.position,
      erroreMessage: erroreMessage ?? this.erroreMessage,
    );
  }
}
