import 'package:flutter/material.dart';
import 'package:appv/models/anime.dart';
import 'package:appv/models/episode.dart';
import 'package:appv/screens/home/watch_screen.dart';
import 'package:appv/services/api_service.dart';
import 'package:appv/widgets/episode_card.dart';

class AnimeDetailScreen extends StatefulWidget {
  final Anime anime;

  const AnimeDetailScreen({super.key, required this.anime});

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Episode>> _episodes;

  @override
  void initState() {
    super.initState();
    _episodes = _apiService.fetchAnimeEpisodes(widget.anime.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.anime.coverImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.anime.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${widget.anime.releaseYear} • ${widget.anime.studio}',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      const Spacer(),
                      Icon(Icons.star, color: Colors.amber),
                      Text(widget.anime.rating.toString()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.anime.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Episodes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: FutureBuilder<List<Episode>>(
              future: _episodes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No episodes available')),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final episode = snapshot.data![index];
                      return EpisodeCard(
                        episode: episode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WatchScreen(episode: episode),
                            ),
                          );
                        },
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
