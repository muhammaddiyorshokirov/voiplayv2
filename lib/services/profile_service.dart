// services/profile_service.dart
// Profil bilan bog'liq API so'rovlari

import 'package:voiplay/models/profile.dart';
import 'api_service.dart';

class ProfileService {
  static Future<Profile> getProfile(String id) async {
    final response = await ApiService.get('/users/$id');
    return Profile.fromJson(response);
  }

  static Future<void> updateProfile(String id, Map<String, dynamic> data) async {
    await ApiService.put('/users/$id', data);
  }
}