// models/user.dart
// Foydalanuvchi ma'lumotlari uchun model

class User {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final String? bio;
  final String role;
  final bool premiumStatus;
  final String? premiumExpiresAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.bio,
    required this.role,
    required this.premiumStatus,
    this.premiumExpiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
      role: json['role'],
      premiumStatus: json['premium_status'],
      premiumExpiresAt: json['premium_expires_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}