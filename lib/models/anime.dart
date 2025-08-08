// models/anime.dart
// Anime ma'lumotlari uchun model

class Anime {
  final String id;
  final String title;
  final String slug;
  final String? image;
  final String? coverImage;
  final String? description;
  final String? studio;
  final String? language;
  final int releaseYear;
  final String? duration;
  final String? status;
  final double rating;
  final bool isPremium;
  final String? premiumUnlockAt;
  final int views;
  final String createdAt;
  final String updatedAt;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final List<String>? genres;

  Anime({
    required this.id,
    required this.title,
    required this.slug,
    this.image,
    this.coverImage,
    this.description,
    this.studio,
    this.language,
    required this.releaseYear,
    this.duration,
    this.status,
    required this.rating,
    required this.isPremium,
    this.premiumUnlockAt,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.genres,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      image: json['image'],
      coverImage: json['cover_image'],
      description: json['description'],
      studio: json['studio'],
      language: json['language'],
      releaseYear: json['release_year'],
      duration: json['duration'],
      status: json['status'],
      rating: json['rating'].toDouble(),
      isPremium: json['is_premium'],
      premiumUnlockAt: json['premium_unlock_at'],
      views: json['views'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : null,
    );
  }
}