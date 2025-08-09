import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:anime_tv/models.dart';
import 'package:anime_tv/routes.dart';
import 'package:anime_tv/widgets/error_card.dart';
import 'package:anime_tv/api/api.dart';
import 'package:anime_tv/api/models.dart';
import 'package:anime_tv/widgets/recent_episode_card.dart';
import 'package:anime_tv/utils.dart';

class RecentEpisodesGrid extends StatefulWidget {
  const RecentEpisodesGrid({Key? key}) : super(key: key);

  @override
  State<RecentEpisodesGrid> createState() => _RecentEpisodesGridState();
}

class _RecentEpisodesGridState extends State<RecentEpisodesGrid> {
  late Future<List<RecentEpisode>> _popularList;
  static const double cardExtent = 300;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  Future<void> onRefresh() {
    setState(() {
      _popularList = Api.getRecentEpisodes();
    });
    return _popularList;
  }

  Widget buildSkeleton(BuildContext context) {
    final skeleton = SkeletonAnimation(
      shimmerColor: Theme.of(context).colorScheme.background,
      shimmerDuration: 800,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.lighten(),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: cardExtent,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: cardExtent / RecentEpisodeCard.height,
      ),
      itemBuilder: (_, index) => skeleton,
      itemCount: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecentEpisode>>(
      future: _popularList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final gridView = GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: cardExtent,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: cardExtent / RecentEpisodeCard.height,
            ),
            itemBuilder: (_, index) => RecentEpisodeCard(snapshot.data![index]),
            itemCount: snapshot.data!.length,
          );

          final continueWatchingBtn =
              Consumer<LastEpisode>(builder: (context, lastEpisode, child) {
            if (lastEpisode.get().isNotEmpty) {
              return ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ViewEpisodeRoute.routeName,
                    arguments: lastEpisode.get(),
                  );
                },
                icon: const Icon(Icons.movie),
                label: const Text("Continue Watching"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 50),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          });

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: Stack(
              children: [
                gridView,
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: continueWatchingBtn,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return genericNetworkError;
        } else {
          return buildSkeleton(context);
        }
      },
    );
  }
}
