import 'package:filmler/movies/models/movie_details_model.dart';
import 'package:filmler/movies/models/movie_model.dart';
import 'package:flutter/material.dart';

import 'image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel? movie;
  final MovieDetailModel? movieDetail;
  final double heightBackdrop;
  final double widthBackdrop;
  final double heightPoster;
  final double widthPoster;
  final double radius;
  final void Function()? onTap;

  ItemMovieWidget(
      {this.movie,
      this.movieDetail,
      required this.heightBackdrop,
      required this.widthBackdrop,
      required this.heightPoster,
      required this.widthPoster,
      this.radius = 14,
      this.onTap,
      super.key});

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      );

  @override
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc:
                '${movieDetail != null ? movieDetail!.backdropPath : movie!.backdropPath}',
            height: heightBackdrop,
            width: widthBackdrop,
          ),
          Container(
            height: heightBackdrop,
            width: widthBackdrop,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black45],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  imageSrc:
                      '${movieDetail != null ? movieDetail!.posterPath : movie!.posterPath}',
                  height: heightPoster,
                  width: widthPoster,
                  radius: 14,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  movieDetail != null ? movieDetail!.title : movie!.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amberAccent,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${movieDetail != null ? movieDetail!.voteAverage : movie!.voteAverage}(${movieDetail != null ? movieDetail!.voteCount : movie!.voteCount})',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      );
}
