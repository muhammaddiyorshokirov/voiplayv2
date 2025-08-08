// models/episode.dart
// Episod ma'lumotlari uchun model

class Episode {
  final String id;
  final String animeId;
  final String? animeTitle;
  final String title;
  final int? episodeNumber;
  final String? description;
  final String videoUrl;
  final String? thumbnail;
  final int? duration;
  final bool isPremium;
  final String? premiumUnlockAt;
  final int views;
  final int likes;
  final int dislikes;
  final int commentsCount;
  final String? tags;
  final String? releaseDate;
  final String language;
  final String episodeType;
  final bool isOfficial;
  final bool isActive;
  final String contentMakerId;
  final String createdAt;
  final String updatedAt;
  final String? slug;
  final String? moderatedBy;
  final String? downloadUrl;

  Episode({
    required this.id,
    required this.animeId,
    this.animeTitle,
    required this.title,
    this.episodeNumber,
    this.description,
    required this.videoUrl,
    this.thumbnail,
    this.duration,
    required this.isPremium,
    this.premiumUnlockAt,
    required this.views,
    required this.likes,
    required this.dislikes,
    required this.commentsCount,
    this.tags,
    this.releaseDate,
    required this.language,
    required this.episodeType,
    required this.isOfficial,
    required this.isActive,
    required this.contentMakerId,
    required this.createdAt,
    required this.updatedAt,
    this.slug,
    this.moderatedBy,
    this.downloadUrl,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      animeId: json['anime_id'],
      animeTitle: json['anime_title'],
      title: json['title'],
      episodeNumber: json['episode_number'],
      description: json['description'],
      videoUrl: json['video_url'],
      thumbnail: json['thumbnail'],
      duration: json['duration'],
      isPremium: json['is_premium'],
      premiumUnlockAt: json['premium_unlock_at'],
      views: json['views'],
      likes: json['likes'],
      dislikes: json['dislikes'],
      commentsCount: json['comments_count'],
      tags: json['tags'],
      releaseDate: json['release_date'],
      language: json['language'],
      episodeType: json['episode_type'],
      isOfficial: json['is_official'],
      isActive: json['is_active'],
      contentMakerId: json['content_maker_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      slug: json['slug'],
      moderatedBy: json['moderated_by'],
      downloadUrl: json['download_url'],
    );
  }
}