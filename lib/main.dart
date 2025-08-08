import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'controllers/anime_controller.dart';
import 'controllers/episode_controller.dart';
import 'controllers/user_controller.dart';
import 'controllers/profile_controller.dart';

void main() {
  runApp(const VoiplayApp());
}

class VoiplayApp extends StatelessWidget {
  const VoiplayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnimeController()),
        ChangeNotifierProvider(create: (_) => EpisodeController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: MaterialApp(
        title: 'Voiplay',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
