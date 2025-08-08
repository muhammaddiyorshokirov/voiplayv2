// screens/profile_screen.dart
// Profil ekrani

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/profile_controller.dart';
import '../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final userController = Provider.of<UserController>(context);
    final user = userController.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('Kirish kerak'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: FutureBuilder(
        future: profileController.fetchProfile(user.id),
        builder: (context, snapshot) {
          if (profileController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final profile = profileController.profile;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Foydalanuvchi: ${profile?.username ?? ""}'),
                Text('Email: ${profile?.email ?? ""}'),
                if (profile?.bio != null) Text('Bio: ${profile?.bio}'),
                Text('Til: ${profile?.language ?? "Noma'lum"}'),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Profilni tahrirlash funksiyasi
                  },
                  child: const Text('Profilni tahrirlash'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}