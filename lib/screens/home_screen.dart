import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/anime_controller.dart';
import '../widgets/anime_card.dart';
import '../widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchFuture;

  @override
  void initState() {
    super.initState();
    // Future ni initState ichida olish, shunda build har safar chaqirilganda fetch qilinmaydi
    final animeController =
        Provider.of<AnimeController>(context, listen: false);
    _fetchFuture = animeController.fetchAllAnime();
  }

  @override
  Widget build(BuildContext context) {
    // listen true qilib qoldiramiz, shunda animeController.notifyListeners() UI yangilanadi
    final animeController = Provider.of<AnimeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voiplay'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Xatolik yuz berdi: ${snapshot.error}'));
          }

          final animeList = animeController.animeList;

          if (animeList == null || animeList.isEmpty) {
            return const Center(child: Text('Anime topilmadi'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              return AnimeCard(anime: animeList[index]);
            },
          );
        },
      ),
    );
  }
}
