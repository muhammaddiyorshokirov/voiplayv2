import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:anime_tv/api/api.dart';
import 'package:anime_tv/api/models.dart';
import 'package:anime_tv/routes.dart';
import 'package:anime_tv/widgets/error_card.dart';
import 'package:anime_tv/widgets/image_card.dart';
import 'package:anime_tv/utils.dart';

class SearchResultsView extends StatefulWidget {
  final String query;

  const SearchResultsView({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  late Future<List<Show>> searchResults;
  static const double cardHeight = 400;
  static const double cardExtent = 300;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  Future<void> onRefresh() {
    setState(() {
      searchResults = Api.searchShow(widget.query);
    });
    return searchResults;
  }

  Widget buildSkeleton(BuildContext context) {
    final theme = Theme.of(context);
    final cardSkeleton = SkeletonAnimation(
      shimmerColor: theme.colorScheme.background, // YANGILANDI
      shimmerDuration: 800,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background.lighten(),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          child: cardSkeleton,
          height: 20,
          width: MediaQuery.of(context).size.width / 2,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: cardExtent,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: cardExtent / cardHeight,
            ),
            itemBuilder: (_, __) => cardSkeleton,
            itemCount: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Show>>(
      future: searchResults,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final shows = snapshot.data!;
          final widgets = shows.map((show) {
            final image = (show.image.isEmpty
                ? const AssetImage('assets/cover_placeholder.jpg')
                : NetworkImage(show.image)) as ImageProvider;

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ShowDetailRoute.routeName,
                  arguments: show.url,
                );
              },
              child: ImageCard(
                title: show.title,
                image: image,
                height: cardHeight,
              ),
            );
          }).toList();

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  "${widgets.length} results for '${widget.query}'",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: cardExtent,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: cardExtent / cardHeight,
                    ),
                    itemCount: widgets.length,
                    itemBuilder: (_, index) => widgets[index],
                  ),
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
