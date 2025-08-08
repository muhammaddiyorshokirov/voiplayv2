// controllers/profile_controller.dart
// Profil ma'lumotlarini boshqarish

import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../services/profile_service.dart';

class ProfileController with ChangeNotifier {
  Profile? _profile;
  bool _isLoading = false;

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> fetchProfile(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _profile = await ProfileService.getProfile(id);
    } catch (e) {
      print('Xato: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await ProfileService.updateProfile(id, data);
      _profile = await ProfileService.getProfile(id);
    } catch (e) {
      print('Xato: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}