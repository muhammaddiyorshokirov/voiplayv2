// home_screen.dart
import 'package:flutter/material.dart';
import 'package:appv/models/anime.dart';
import 'package:appv/models/episode.dart';
import 'package:appv/screens/anime_list_screen.dart';
import 'package:appv/screens/home/anime_detail_screen.dart';
import 'package:appv/screens/home/watch_screen.dart';
import 'package:appv/screens/profile/profile_screen.dart';
import 'package:appv/services/api_service.dart';
import 'package:appv/widgets/anime_card.dart';
import 'package:appv/widgets/episode_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Anime>> _trendingAnime;
  late Future<List<Anime>> _recentAnime;
  late Future<List<Episode>> _recentEpisodes;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _trendingAnime = _apiService.fetchTrendingAnime();
    _recentAnime = _apiService.fetchRecentAnime();
    _recentEpisodes = _apiService.fetchRecentEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Anime List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const AnimeListScreen();
      case 2:
        return const ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Trending Now'),
          _buildAnimeList(_trendingAnime),
          _buildSectionTitle('Recently Added'),
          _buildAnimeList(_recentAnime),
          _buildSectionTitle('New Episodes'),
          _buildEpisodeList(_recentEpisodes),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnimeList(Future<List<Anime>> futureAnime) {
    return SizedBox(
      height: 260,
      child: FutureBuilder<List<Anime>>(
        future: futureAnime,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No anime found'));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final anime = snapshot.data![index];
              return AnimeCard(
                anime: anime,
                onTap: () => _navigateToAnimeDetail(anime),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEpisodeList(Future<List<Episode>> futureEpisodes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<List<Episode>>(
        future: futureEpisodes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No episodes found'));
          }

          return Column(
            children: snapshot.data!
                .map((episode) => EpisodeCard(
                      episode: episode,
                      onTap: () => _navigateToWatchScreen(episode),
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  void _navigateToAnimeDetail(Anime anime) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnimeDetailScreen(anime: anime),
      ),
    );
  }

  void _navigateToWatchScreen(Episode episode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WatchScreen(episode: episode),
      ),
    );
  }
}
