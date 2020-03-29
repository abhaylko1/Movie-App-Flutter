import 'package:Movies/src/modules/MovieDetail.dart';
import 'package:Movies/src/modules/MovieList.dart';
import 'package:dio/dio.dart';

class MovieProvider {
  final API_URL = 'http://api.themoviedb.org/3/movie';
  final API_KEY = '802b2c4b88ea1183e50e6b285a27696e';

  Dio dio = new Dio();

  Future<MovieList> getMovieList() async {
    final response = await dio.get("$API_URL/popular?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.data);
    } else {
      throw Exception('Something wents wrong. Please try later.');
    }
  }

  Future<MovieDetail> getMovieDetails(String id) async {
    final response = await dio.get("$API_URL/$id/videos?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieDetail.fromJson(response.data);
    } else {
      throw Exception('Something wents wrong. Please try later.');
    }
  }
}
