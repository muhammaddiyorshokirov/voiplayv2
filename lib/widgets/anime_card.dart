import 'package:flutter/material.dart';
import 'package:appv/models/anime.dart';
import 'package:appv/widgets/premium_badge.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback onTap;

  const AnimeCard({
    super.key,
    required this.anime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    anime.image,
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 150,
                      height: 220,
                      color: Colors.grey[800],
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
                if (anime.isPremium)
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: PremiumBadge(),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              anime.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${anime.releaseYear} • ${anime.rating} ⭐',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
