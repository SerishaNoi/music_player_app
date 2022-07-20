class MusicEntity {
  final String artistName;
  final String collectionName;
  final String trackName;
  final int trackId;
  final String previewUrl;
  final String artworkUrl30;
  final String artworkUrl60;
  final String artworkUrl100;
  final String releaseDate;

  const MusicEntity({
    required this.artistName,
    required this.collectionName,
    required this.trackName,
    required this.trackId,
    required this.previewUrl,
    required this.artworkUrl30,
    required this.artworkUrl60,
    required this.artworkUrl100,
    required this.releaseDate,
  });

  List<Object> get props => [
        artistName,
        collectionName,
        trackName,
        trackId,
        previewUrl,
        artworkUrl30,
        artworkUrl60,
        artworkUrl100,
        releaseDate
      ];

  bool? get stringify => true;
}
