import 'package:flutter/material.dart';
import 'package:appv/models/episode.dart';
import 'package:appv/widgets/episode_card.dart';

class WatchScreen extends StatefulWidget {
  final Episode episode;

  const WatchScreen({super.key, required this.episode});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  late bool _isPremiumContent;
  late bool _hasAccess;

  @override
  void initState() {
    super.initState();
    _isPremiumContent = widget.episode.isPremium;
    // In a real app, you would check if the user has premium access
    _hasAccess =
        !_isPremiumContent; // Demo: free users can only watch free content
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildVideoPlayer(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.episode.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Episode ${widget.episode.episodeNumber} • ${widget.episode.views} views',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 16),
                  Text(widget.episode.description),
                  const SizedBox(height: 24),
                  _buildEpisodeList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_isPremiumContent && !_hasAccess) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 50, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                'Premium Content',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upgrade to premium to watch this content',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to premium subscription page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: const Text('Upgrade Now'),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
            const SizedBox(height: 16),
            const Text(
              'Video Player',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Playing: ${widget.episode.title}',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodeList() {
    // In a real app, you would fetch episodes for this anime
    // For demo, we'll just show the current episode
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'More Episodes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        EpisodeCard(
          episode: widget.episode,
          onTap: () {},
          isSelected: true,
        ),
      ],
    );
  }
}
