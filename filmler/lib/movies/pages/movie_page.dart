
import 'package:filmler/movies/component/movie_discover_component.dart';
import 'package:filmler/movies/component/movie_now_playing_component.dart';
import 'package:filmler/movies/component/movie_top_rated_component.dart';
import 'package:filmler/movies/pages/movie_pagination_page.dart';
import 'package:filmler/movies/pages/movie_search_page.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
           SliverAppBar(
            title: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                Text(
                  'FİLMLER',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: MovieSearchPage(),
                ),
                icon: const Icon(Icons.search),
              ),
            ],
            floating: true,
            snap: true,
            centerTitle: true,
            foregroundColor: Colors.grey,
          ),
          WidgetTitle(
            title: 'Keşfet',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MoviePaginationPage(type: TypeMovie.discover,),
                ),
              );
            },
          ),
          const MovieDiscoverComponent(),
          WidgetTitle(
            title: 'En çok beğenilenler',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MoviePaginationPage(type: TypeMovie.popular,),
                ),
              );
            },
          ),
          const MovieTopRatedComponent(),
          WidgetTitle(
            title: 'Vizyondakiler',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MoviePaginationPage(type: TypeMovie.nowPlayer,),
                ),
              );
            },
          ),
          const MovieNowPlayingComponent(),
          SliverToBoxAdapter(
            child: SizedBox(height: 16,),
          ),

        ],
      ),
    );
  }
}

class WidgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const WidgetTitle({required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                shape: const StadiumBorder(),
                side: const BorderSide(
                  color: Colors.black45,
                ),
              ),
              child: const Text('Tümünü Gör'),
            ),
          ],
        ),
      );
}
