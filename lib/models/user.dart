class User {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final String? bio;
  final String role;
  final bool isPremium;
  final DateTime? premiumExpiresAt;
  final String language;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.bio,
    required this.role,
    required this.isPremium,
    this.premiumExpiresAt,
    required this.language,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      bio: json['bio'],
      role: json['role'] ?? 'user',
      isPremium: json['premium_status'] == 1,
      premiumExpiresAt: json['premium_expires_at'] != null
          ? DateTime.parse(json['premium_expires_at'])
          : null,
      language: json['language'] ?? 'en',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'role': role,
      'premium_status': isPremium ? 1 : 0,
      'premium_expires_at': premiumExpiresAt?.toIso8601String(),
      'language': language,
    };
  }
}
