import 'package:flutter/material.dart';
import 'package:anime_tv/pages/home.dart';
import 'package:anime_tv/routes.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:provider/provider.dart';
import 'models.dart';

Future<void> main() async {
  // Flutter binding tayyor bo'lishi uchun
  WidgetsFlutterBinding.ensureInitialized();

  // StreamingSharedPreferences instance yaratish
  final prefs = await StreamingSharedPreferences.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WatchedEpisodes(prefs)),
        ChangeNotifierProvider(create: (_) => FavoriteShows(prefs)),
        ChangeNotifierProvider(create: (_) => LastEpisode(prefs)),
      ],
      child: const AnimeTV(),
    ),
  );
}

class AnimeTV extends StatelessWidget {
  const AnimeTV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime TV',
      debugShowCheckedModeBanner: false, // Debug banner olib tashlandi
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
          background: const Color.fromARGB(255, 15, 15, 15),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        ViewEpisodeRoute.routeName: (context) => const ViewEpisodeRoute(),
        ShowDetailRoute.routeName: (context) => const ShowDetailRoute(),
        SearchResultsRoute.routeName: (context) => const SearchResultsRoute(),
      },
    );
  }
}
