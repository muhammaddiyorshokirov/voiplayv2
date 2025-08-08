import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';
import '../models/episode.dart';
import '../utils/constants.dart';

class ApiService {
  final String _baseUrl = ApiConstants.baseUrl;

  // Trenddagi animelar
  Future<List<Anime>> fetchTrendingAnime() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/anime/trending'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Trenddagi animelarni yuklab bo‘lmadi');
    }
  }

  // Barcha animelar
  Future<List<Anime>> fetchAllAnime() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/anime'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Animelarni yuklab bo‘lmadi');
    }
  }

  // Barcha qismlar
  Future<List<Episode>> fetchAllEpisodes() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/episode'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Episode.fromJson(json)).toList();
    } else {
      throw Exception('Qismlarni yuklab bo‘lmadi');
    }
  }

  // Anime tafsilotlari
  Future<Anime> fetchAnimeDetails(String animeId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/anime/$animeId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      return Anime.fromJson(data);
    } else {
      throw Exception('Anime tafsilotlarini yuklab bo‘lmadi');
    }
  }

  // Anime qismlari
  Future<List<Episode>> fetchAnimeEpisodes(String animeId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/anime/$animeId/episodes'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Episode.fromJson(json)).toList();
    } else {
      throw Exception('Anime qismlarini yuklab bo‘lmadi');
    }
  }

  // Qidiruv
  Future<List<Anime>> searchAnime(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search?query=$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Qidiruv natijalari topilmadi');
    }
  }

  // ✅ Yaqinda qo‘shilgan animelar
  Future<List<Anime>> fetchRecentAnime() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/anime'), // kerak bo‘lsa params qo‘shing
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Yaqinda qo‘shilgan animelarni yuklab bo‘lmadi');
    }
  }

  // ✅ Yaqinda qo‘shilgan qismlar
  Future<List<Episode>> fetchRecentEpisodes() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/episode'), // kerak bo‘lsa params qo‘shing
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Episode.fromJson(json)).toList();
    } else {
      throw Exception('Yaqinda qo‘shilgan episodelarni yuklab bo‘lmadi');
    }
  }
}
