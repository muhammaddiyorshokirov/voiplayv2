class Anime {
  final String id;
  final String title;
  final String slug;
  final String image;
  final String coverImage;
  final String description;
  final String studio;
  final String language;
  final int releaseYear;
  final String duration;
  final String status;
  final double rating;
  final bool isPremium;
  final int views;
  final DateTime createdAt;

  Anime({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.coverImage,
    required this.description,
    required this.studio,
    required this.language,
    required this.releaseYear,
    required this.duration,
    required this.status,
    required this.rating,
    required this.isPremium,
    required this.views,
    required this.createdAt,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'].toString(),
      title: json['title'] ?? 'No title',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      coverImage: json['cover_image'] ?? '',
      description: json['description'] ?? '',
      studio: json['studio'] ?? '',
      language: json['language'] ?? 'en',
      releaseYear: int.tryParse(json['release_year'].toString()) ?? 0,
      duration: json['duration']?.toString() ?? '0',
      status: json['status'] ?? 'completed',
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      isPremium: json['is_premium'].toString() == '1',
      views: int.tryParse(json['views'].toString()) ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
