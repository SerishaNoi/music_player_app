import 'package:music_player_app/src/API/data/api_client.dart';
import 'package:music_player_app/src/API/models/music_model.dart';
import 'package:music_player_app/src/API/models/music_result_model.dart';

abstract class MusicDataSource {
  Future<List<MusicModel>> getMusicBySearch({String? searchText});
}

class MusicDataSourceImpl extends MusicDataSource {
  final ApiClient client;

  MusicDataSourceImpl({required this.client});

  @override
  Future<List<MusicModel>> getMusicBySearch({String? searchText}) async {
    final response = await client.get('/search', quaryParams: {
      'term': searchText,
      'media': 'music',
      'limit': '20',
    });

    return MusicResultModel.fromJson(response).music;
  }
}
