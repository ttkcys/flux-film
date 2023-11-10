import 'package:filmler/movies/models/movie_model.dart';
import 'package:filmler/movies/pages/movie_detail_page.dart';
import 'package:filmler/movies/providers/movie_get_discover_provider.dart';
import 'package:filmler/movies/providers/movie_get_now_playing_provider.dart';
import 'package:filmler/movies/providers/movie_get_topRated_provider.dart';
import 'package:filmler/widget/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

enum TypeMovie { discover, popular, nowPlayer }

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.type});

  final TypeMovie type;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      switch (widget.type) {
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
        case TypeMovie.popular:
          context.read<MovieGetTopRatedProvider>().getTopRatedWithPagination(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
        case TypeMovie.nowPlayer:
          context
              .read<MovieGetNowPlayingProvider>()
              .getNowPlayingWithPagination(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (_) {
          switch (widget.type) {
            case TypeMovie.discover:
              return const Text('Keşfetteki Filmler');
            case TypeMovie.popular:
              return const Text('En Çok Beğenilen Filmler');
            case TypeMovie.nowPlayer:
              return const Text('Vizyondaki Filmler');
          }
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagedListView.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieModel>(
            itemBuilder: (context, item, index) => ItemMovieWidget(
              movie: item,
              heightBackdrop: 180,
              widthBackdrop: double.infinity,
              heightPoster: 100,
              widthPoster: 60,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MovieDetailPage(id: item.id)));
              },
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 8,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
