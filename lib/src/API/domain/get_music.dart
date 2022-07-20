import 'package:music_player_app/src/API/models/music_entity.dart';
import 'package:music_player_app/src/repository/music_repository.dart';

class GetMusic {
  final MusicRepository repository;

  GetMusic({
    required this.repository,
  });

  Future<List<MusicEntity>> getMusic(GetMusicParams params) async {
    return await repository.getMusicBySearch(searchText: params.searchText);
  }
}

class GetMusicParams {
  final String searchText;

  const GetMusicParams({
    required this.searchText,
  });

  List<Object> get props => [searchText];
}
