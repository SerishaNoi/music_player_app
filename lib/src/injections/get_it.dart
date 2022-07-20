import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/src/API/data/api_client.dart';
import 'package:music_player_app/src/API/data/music_data_source.dart';
import 'package:music_player_app/src/API/domain/get_music.dart';
import 'package:music_player_app/src/bloc/music_cubit/music_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_cubit.dart';
import 'package:music_player_app/src/repository/music_repository.dart';

final getItInstance = GetIt.instance;

Future getItInit() async {
  // Cubits
  getItInstance.registerFactory(
    () => MusicCubit(getMusic: getItInstance()),
  );
  getItInstance.registerFactory(
    () => PlayerCubit(musicPlayer: getItInstance()),
  );

  getItInstance.registerLazySingleton<MusicDataSource>(
    () => MusicDataSourceImpl(client: getItInstance()),
  );

  getItInstance.registerLazySingleton<MusicRepository>(
    () => MusicRepositoryImpl(musicDataSource: getItInstance()),
  );

  getItInstance.registerLazySingleton<GetMusic>(
    () => GetMusic(repository: getItInstance()),
  );

  getItInstance.registerLazySingleton(
    () => ApiClient(getItInstance()),
  );

  getItInstance.registerLazySingleton(() => AudioPlayer());
  getItInstance.registerLazySingleton(() => Client());
}
