// widgets/episode_tile.dart
// Episod ro'yxati uchun widget

import 'package:flutter/material.dart';
import '../models/episode.dart';
import '../screens/episode_player_screen.dart';

class EpisodeTile extends StatelessWidget {
  final Episode episode;

  const EpisodeTile({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: episode.thumbnail != null
          ? Image.network(episode.thumbnail!, width: 50, fit: BoxFit.cover)
          : const Icon(Icons.videocam),
      title: Text(episode.title),
      subtitle: Text('Episod: ${episode.episodeNumber ?? "Noma'lum"}'),
      onTap: () => Navigator.pushNamed(
        context,
        '/episode_player',
        arguments: episode,
      ),
    );
  }
}