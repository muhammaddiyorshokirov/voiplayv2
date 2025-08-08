// controllers/user_controller.dart
// Foydalanuvchi ma'lumotlarini boshqarish

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';

class UserController with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _currentUser = await AuthService.login(email, password);
    } catch (e) {
      print('Xato: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(String username, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _currentUser = await AuthService.register(username, email, password);
    } catch (e) {
      print('Xato: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}