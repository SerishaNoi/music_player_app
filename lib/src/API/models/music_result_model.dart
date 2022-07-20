import 'music_model.dart';

class MusicResultModel {
  final int resultCount;
  final List<MusicModel> music;

  MusicResultModel({
    required this.resultCount,
    required this.music,
  });

  factory MusicResultModel.fromJson(Map<String, dynamic> json) {
    final resultCount = json['resultCount'];
    final List<MusicModel> musicResult = <MusicModel>[];

    if (json['results'] != null) {
      json['results'].forEach((e) {
        musicResult.add(MusicModel.fromJson(e));
      });
    }
    return MusicResultModel(resultCount: resultCount, music: musicResult);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['resultCount'] = resultCount;

    data['results'] = music.map((e) => e.toJson()).toList();

    return data;
  }
}
