class Episode {
  final String id;
  final String animeId;
  final String title;
  final int? episodeNumber;
  final String description;
  final String videoUrl;
  final String thumbnail;
  final int duration;
  final bool isPremium;
  final int views;
  final int likes;
  final int dislikes;
  final String language;
  final String episodeType;
  final DateTime releaseDate;
  final DateTime createdAt;

  Episode({
    required this.id,
    required this.animeId,
    required this.title,
    this.episodeNumber,
    required this.description,
    required this.videoUrl,
    required this.thumbnail,
    required this.duration,
    required this.isPremium,
    required this.views,
    required this.likes,
    required this.dislikes,
    required this.language,
    required this.episodeType,
    required this.releaseDate,
    required this.createdAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'].toString(),
      animeId: json['anime_id'].toString(),
      title: json['title'] ?? 'No title',
      episodeNumber: json['episode_number'] != null
          ? int.tryParse(json['episode_number'].toString())
          : null,
      description: json['description'] ?? '',
      videoUrl: json['video_url'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      duration: int.tryParse(json['duration'].toString()) ?? 0,
      isPremium: json['is_premium'].toString() == '1',
      views: int.tryParse(json['views'].toString()) ?? 0,
      likes: int.tryParse(json['likes'].toString()) ?? 0,
      dislikes: int.tryParse(json['dislikes'].toString()) ?? 0,
      language: json['language'] ?? 'en',
      episodeType: json['episode_type'] ?? 'standard',
      releaseDate: DateTime.tryParse(json['release_date'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  String get formattedDuration {
    final duration = Duration(seconds: this.duration);
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
