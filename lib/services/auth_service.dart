// services/auth_service.dart
// Autentifikatsiya bilan bog'liq xizmatlar

import 'package:voiplay/models/user.dart';
import 'api_service.dart';

class AuthService {
  static Future<User> login(String email, String password) async {
    final response = await ApiService.post('/users', {
      'email': email,
      'password': password,
    });
    return User.fromJson(response);
  }

  static Future<User> register(String username, String email, String password) async {
    final response = await ApiService.post('/users', {
      'username': username,
      'email': email,
      'password': password,
    });
    return User.fromJson(response);
  }
}