import 'package:music_player_app/src/API/data/music_data_source.dart';
import 'package:music_player_app/src/API/models/music_entity.dart';
// import 'package:music_player_app/src/API/models/music_model.dart';

abstract class MusicRepository {
  Future<List<MusicEntity>> getMusicBySearch({String? searchText});
}

class MusicRepositoryImpl extends MusicRepository {
  final MusicDataSource musicDataSource;

  MusicRepositoryImpl({
    required this.musicDataSource,
  });

  @override
  Future<List<MusicEntity>> getMusicBySearch({String? searchText}) async {
    final results = await musicDataSource.getMusicBySearch(searchText: searchText);
    return results;
  }
}
