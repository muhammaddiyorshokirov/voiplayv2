import '../models/anime.dart';
import '../models/episode.dart';
import 'api_service.dart';

class AnimeService {
  static Future<List<Anime>> getAllAnime() async {
    final response = await ApiService.get('/anime');
    return (response['anime'] as List)
        .map((json) => Anime.fromJson(json))
        .toList();
  }

  static Future<Anime> getAnimeById(String id) async {
    final response = await ApiService.get('/anime/$id');
    return Anime.fromJson(response);
  }

  static Future<List<Episode>> getAnimeEpisodes(String id) async {
    final response = await ApiService.get('/anime/$id/episodes');
    return (response['episodes'] as List)
        .map((json) => Episode.fromJson(json))
        .toList();
  }

  static Future<String> createAnime(Map<String, dynamic> data) async {
    final response = await ApiService.post('/anime', data);
    return response['id'];
  }

  static Future<void> updateAnime(String id, Map<String, dynamic> data) async {
    await ApiService.put('/anime/$id', data);
  }

  static Future<void> deleteAnime(String id) async {
    await ApiService.delete('/anime/$id');
  }
}
