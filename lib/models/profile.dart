// models/profile.dart
// Profil ma'lumotlari uchun model

class Profile {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final String? bio;
  final String language;

  Profile({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.bio,
    required this.language,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
      language: json['language'],
    );
  }
}