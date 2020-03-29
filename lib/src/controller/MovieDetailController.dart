import 'dart:async';

import 'package:Movies/src/modules/MovieDetail.dart';
import 'package:Movies/src/modules/MovieList.dart';
import 'package:Movies/src/resources/MovieProvider.dart';

class MovieDetailController {
  final movieProvider = MovieProvider();
  final StreamController movieDetailStreamController =
      StreamController<MovieDetail>.broadcast();

  Stream<MovieDetail> get movieDetail => movieDetailStreamController.stream;

  getMovieDetail(String id) async {
    MovieDetail itemModel = await movieProvider.getMovieDetails(id);
    movieDetailStreamController.sink.add(itemModel);
  }

  dispose() {
    movieDetailStreamController.close();
  }
}

final movieDetailController = MovieDetailController();
