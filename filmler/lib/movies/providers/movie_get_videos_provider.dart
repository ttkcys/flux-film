import 'package:filmler/movies/models/movie_videos_model.dart';
import 'package:filmler/movies/repository/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieGetVideosProvider with ChangeNotifier{
  final MovieRepository _movieRepository;

  MovieGetVideosProvider(this._movieRepository);

  MovieVideosModel? _videos;

  MovieVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _movieRepository.getVideos(id: id);
    result.fold(
          (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),),);
        _videos = null;
        notifyListeners();
        return;
      },
          (response) {
        _videos = response;
        notifyListeners();
        return;
      },
    );
  }
}