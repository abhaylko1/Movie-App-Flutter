import 'dart:async';

import 'package:Movies/src/modules/MovieDetail.dart';
import 'package:Movies/src/modules/MovieList.dart';
import 'package:Movies/src/resources/MovieProvider.dart';

class MoviesListController {
  final movieProvider = MovieProvider();
  final movieListStreamController = StreamController<MovieList>();

  Stream<MovieList> get movieList => movieListStreamController.stream;

  getAllMovieList() async {
    MovieList itemModel = await movieProvider.getMovieList();
    movieListStreamController.sink.add(itemModel);
  }

  dispose() {
    movieListStreamController.close();
  }
}

final movieListController = MoviesListController();
