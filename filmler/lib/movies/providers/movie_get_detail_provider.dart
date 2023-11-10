import 'package:filmler/movies/models/movie_details_model.dart';
import 'package:filmler/movies/repository/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDetailProvider(this._movieRepository);

  MovieDetailModel? _movie;

  MovieDetailModel? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await _movieRepository.getDetail(id: id);
    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),),);
        _movie = null;
        notifyListeners();
        return;
      },
      (response) {
        _movie = response;
        notifyListeners();
        return;
      },
    );
  }
}
