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
      episodeNumber: json['episode_number'],
      description: json['description'] ?? '',
      videoUrl: json['video_url'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      duration: json['duration'] ?? 0,
      isPremium: json['is_premium'] == 1,
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
      language: json['language'] ?? 'en',
      episodeType: json['episode_type'] ?? 'standard',
      releaseDate:
          DateTime.parse(json['release_date'] ?? DateTime.now().toString()),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  String get formattedDuration {
    final duration = Duration(seconds: this.duration);
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
