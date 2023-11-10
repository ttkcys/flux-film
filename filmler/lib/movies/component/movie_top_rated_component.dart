import 'package:filmler/movies/pages/movie_detail_page.dart';
import 'package:filmler/movies/providers/movie_get_topRated_provider.dart';
import 'package:filmler/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieTopRatedComponent extends StatefulWidget {
  const MovieTopRatedComponent({super.key});

  @override
  State<MovieTopRatedComponent> createState() => _MovieTopRatedComponentState();
}

class _MovieTopRatedComponentState extends State<MovieTopRatedComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetTopRatedProvider>().getTopRated(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Consumer<MovieGetTopRatedProvider>(
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
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return ImageNetworkWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MovieDetailPage(
                                  id: provider.movies[index].id)));
                    },
                    imageSrc: provider.movies[index].posterPath,
                    height: 200,
                    width: 140,
                    radius: 14,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  width: 8,
                ),
                itemCount: provider.movies.length,
              );
            }
            return Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(14)),
              child: const Center(
                child: Text(
                  'En çok beeğenilen filmlerde film bulunamadı!!!',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
