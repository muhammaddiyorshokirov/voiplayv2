import '../models/episode.dart';
import 'api_service.dart';

class EpisodeService {
  static Future<List<Episode>> getAllEpisodes() async {
    final response = await ApiService.get('/episodes');
    return (response['episodes'] as List)
        .map((json) => Episode.fromJson(json))
        .toList();
  }

  static Future<List<Episode>> getAnimeEpisodes(String animeId) async {
    final response = await ApiService.get('/anime/$animeId/episodes');
    return (response['episodes'] as List)
        .map((json) => Episode.fromJson(json))
        .toList();
  }

  static Future<Episode> getEpisodeById(String id) async {
    final response = await ApiService.get('/episodes/$id');
    return Episode.fromJson(response);
  }

  static Future<String> createEpisode(Map<String, dynamic> data) async {
    final response = await ApiService.post('/episodes', data);
    return response['id'];
  }

  static Future<void> updateEpisode(
      String id, Map<String, dynamic> data) async {
    await ApiService.put('/episodes/$id', data);
  }

  static Future<void> deleteEpisode(String id) async {
    await ApiService.delete('/episodes/$id');
  }
}
