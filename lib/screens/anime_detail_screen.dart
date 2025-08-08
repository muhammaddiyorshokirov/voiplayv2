// screens/anime_detail_screen.dart
// Anime tafsilotlari ekrani

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime.dart';
import '../controllers/episode_controller.dart';
import '../widgets/episode_tile.dart';
import '../widgets/loading_indicator.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final episodeController = Provider.of<EpisodeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (anime.image != null)
              Image.network(
                anime.image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(anime.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8.0),
                  Text('Yil: ${anime.releaseYear}'),
                  Text('Reyting: ${anime.rating}'),
                  Text('Status: ${anime.status ?? "Noma\'lum"}'),
                  if (anime.description != null) ...[
                    const SizedBox(height: 8.0),
                    Text(anime.description!),
                  ],
                ],
              ),
            ),
            FutureBuilder(
              future: episodeController.fetchAnimeEpisodes(anime.id),
              builder: (context, snapshot) {
                if (episodeController.isLoading) {
                  return const LoadingIndicator();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: episodeController.episodeList.length,
                  itemBuilder: (context, index) {
                    return EpisodeTile(
                        episode: episodeController.episodeList[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
