// routes.dart
// Ilova marshrutlari

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/anime_detail_screen.dart';
import 'screens/episode_player_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import '../models/anime.dart';
import '../models/episode.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/anime_detail':
        if (args is Anime) {
          return MaterialPageRoute(builder: (_) => AnimeDetailScreen(anime: args));
        }
        return _errorRoute();
      case '/episode_player':
        if (args is Episode) {
          return MaterialPageRoute(builder: (_) => EpisodePlayerScreen(episode: args));
        }
        return _errorRoute();
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Xato: Sahifa topilmadi'),
        ),
      ),
    );
  }
}