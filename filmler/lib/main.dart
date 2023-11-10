
import 'package:filmler/injector.dart';
import 'package:filmler/movies/pages/movie_page.dart';
import 'package:filmler/movies/providers/movie_get_discover_provider.dart';
import 'package:filmler/movies/providers/movie_get_now_playing_provider.dart';
import 'package:filmler/movies/providers/movie_get_topRated_provider.dart';
import 'package:filmler/movies/providers/movie_search_provider.dart';
import 'package:filmler/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setup();
  runApp( App());
}


class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<MovieGetDiscoverProvider>(),),
        ChangeNotifierProvider(create: (_) => sl<MovieGetTopRatedProvider>(),),
        ChangeNotifierProvider(create: (_) => sl<MovieGetNowPlayingProvider>(),),
        ChangeNotifierProvider(create: (_) => sl<MovieSearchProvider>(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MoviePage(),
      ),
    );
  }
}
