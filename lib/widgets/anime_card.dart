// widgets/anime_card.dart
// Anime kartasi uchun widget

import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../screens/anime_detail_screen.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/anime_detail',
        arguments: anime,
      ),
      child: Card(
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (anime.image != null)
              Image.network(
                anime.image!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                anime.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}