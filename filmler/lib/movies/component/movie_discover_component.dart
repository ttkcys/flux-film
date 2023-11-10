import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmler/movies/pages/movie_detail_page.dart';
import 'package:filmler/movies/providers/movie_get_discover_provider.dart';
import 'package:filmler/widget/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDiscoverComponent extends StatefulWidget {
  const MovieDiscoverComponent({super.key});

  @override
  State<MovieDiscoverComponent> createState() => _MovieDiscoverComponentState();
}

class _MovieDiscoverComponentState extends State<MovieDiscoverComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(14),
              ),
            );
          }
          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_, index, __) {
                final movie = provider.movies[index];
                return ItemMovieWidget(
                  movie: movie,
                  heightBackdrop: 200,
                  widthBackdrop: double.infinity,
                  heightPoster: 120,
                  widthPoster: 80,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailPage(id: movie.id)));
                  },
                );
              },
              options: CarouselOptions(
                height: 200.0,
                viewportFraction: 0.8,
                reverse: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(14)),
            child: const Center(
              child: Text(
                'Keşfette film bulunamadı!!!',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      ),
    );
  }
}