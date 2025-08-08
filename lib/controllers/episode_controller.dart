import 'package:flutter/material.dart';
import '../models/episode.dart';
import '../services/episode_service.dart'; // faqat EpisodeService import qiling

class EpisodeController with ChangeNotifier {
  List<Episode> _episodeList = [];
  bool _isLoading = false;

  List<Episode> get episodeList => _episodeList;
  bool get isLoading => _isLoading;

  Future<void> fetchAnimeEpisodes(String animeId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _episodeList = await EpisodeService.getAnimeEpisodes(animeId);
    } catch (e) {
      print('Xato: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<Episode?> getEpisodeById(String id) async {
    try {
      return await EpisodeService.getEpisodeById(id);
    } catch (e) {
      print('Xato: $e');
      return null;
    }
  }
}
