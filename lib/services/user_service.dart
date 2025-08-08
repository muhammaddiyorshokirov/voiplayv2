// services/user_service.dart
// Foydalanuvchi bilan bog'liq API so'rovlari

import 'package:voiplay/models/user.dart';
import 'api_service.dart';

class UserService {
  static Future<List<User>> getAllUsers() async {
    final response = await ApiService.get('/users');
    return (response['users'] as List).map((json) => User.fromJson(json)).toList();
  }

  static Future<User> getUserById(String id) async {
    final response = await ApiService.get('/users/$id');
    return User.fromJson(response);
  }

  static Future<String> createUser(Map<String, dynamic> data) async {
    final response = await ApiService.post('/users', data);
    return response['id'];
  }

  static Future<void> updateUser(String id, Map<String, dynamic> data) async {
    await ApiService.put('/users/$id', data);
  }

  static Future<void> deleteUser(String id) async {
    await ApiService.delete('/users/$id');
  }
}