import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/anime_service.dart';

class AnimeController with ChangeNotifier {
  List<Anime>? _animeList = [];
  bool _isLoading = false;

  List<Anime>? get animeList => _animeList;
  bool get isLoading => _isLoading;

  Future<void> fetchAllAnime() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedAnime = await AnimeService.getAllAnime();
      _animeList = fetchedAnime;
    } catch (e) {
      print('Xato: $e');
      _animeList = []; // Xatolikda bo‘sh ro‘yxat qilib qo‘yish mumkin
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Anime?> getAnimeById(String id) async {
    try {
      return await AnimeService.getAnimeById(id);
    } catch (e) {
      print('Xato: $e');
      return null;
    }
  }
}
