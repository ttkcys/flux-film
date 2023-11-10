import 'dart:convert';

import 'package:filmler/injector.dart';
import 'package:filmler/movies/providers/movie_get_detail_provider.dart';
import 'package:filmler/movies/providers/movie_get_videos_provider.dart';
import 'package:filmler/widget/image_widget.dart';
import 'package:filmler/widget/item_movie_widget.dart';
import 'package:filmler/widget/webview_widget.dart';
import 'package:filmler/widget/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetDetailProvider>()..getDetail(context, id: id),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetVideosProvider>()..getVideos(context, id: id),
        ),
      ],
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            WidgetAppBar(context),
            Consumer<MovieGetVideosProvider>(
              builder: (_, provider, __) {
                final videos = provider.videos;

                if (videos != null) {
                  return SliverToBoxAdapter(
                      child: _Content(
                    title: 'Videolar',
                    padding: 0,
                    body: SizedBox(
                      height: 160,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 8),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          final video = videos.results[index];
                          return Stack(
                            children: [
                              ImageNetworkWidget(
                                radius: 14,
                                type: TypeSrcImg.external,
                                imageSrc: YoutubePlayer.getThumbnail(
                                  videoId: video.key,
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => YoutubePlayerWidget(
                                            youtubeKey: video.key,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(
                          width: 8,
                        ),
                        itemCount: videos.results.length,
                      ),
                    ),
                  ));
                }

                return SliverToBoxAdapter();
              },
            ),
            WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  WidgetAppBar(this.context);

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_outlined),
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;

            if (movie != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WebViewWidget(
                              title: movie.title, url: movie.homepage),
                        ),
                      );
                    },
                    icon: const Icon(Icons.public_rounded),
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ];

  @override
  double? get expandedHeight => 350;

  @override
  Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return ItemMovieWidget(
              movieDetail: movie,
              heightBackdrop: double.infinity,
              widthBackdrop: double.infinity,
              heightPoster: 200.0,
              widthPoster: 140.0,
              radius: 0,
            );
          }
          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
      );
}

class _Content extends StatelessWidget {
  const _Content({
    super.key,
    required this.title,
    required this.body,
    this.padding = 16,
  });

  final String title;
  final Widget body;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
      ]);

  @override
  Widget? get child =>
      Consumer<MovieGetDetailProvider>(builder: (_, provider, __) {
        final movie = provider.movie;

        if (movie != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Content(
                title: 'Yayın Tarihi',
                body: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey,
                      size: 32,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      movie.releaseDate.toString().split(' ').first,
                      style: const TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              _Content(
                title: 'Türler',
                body: Wrap(
                  spacing: 4,
                  children: movie.genres
                      .map((genre) => Chip(label: Text(genre.name)))
                      .toList(),
                ),
              ),
              _Content(
                title: 'Genel Bakış',
                body: Text(movie.overview),
              ),
              _Content(
                title: 'Özet',
                body: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  children: [
                    _tableContent(
                        title: 'Yetişkin',
                        content: movie.adult ? 'Evet' : 'Hayır'),
                    _tableContent(
                        title: 'Popülerlik', content: '${movie.popularity}'),
                    _tableContent(
                        title: 'Durumu',
                        content: movie.status == 'Released'
                            ? 'Yayında'
                            : 'Yayında değil'),
                    _tableContent(
                        title: 'Bütçe', content: '${movie.budget} Dolar'),
                    _tableContent(
                        title: 'Hasılat', content: '${movie.revenue} Dolar'),
                    _tableContent(title: 'Slogan', content: '${movie.tagline}'),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      });
}
