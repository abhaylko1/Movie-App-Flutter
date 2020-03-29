// To parse this JSON data, do
//
//     final movieList = movieListFromJson(jsonString);

import 'dart:convert';

class MovieList {
  int page;
  int totalResults;
  int totalPages;
  List<MovieResult> results;

  MovieList({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  factory MovieList.fromRawJson(String str) =>
      MovieList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
        page: json["page"] == null ? null : json["page"],
        totalResults:
            json["total_results"] == null ? null : json["total_results"],
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
        results: json["results"] == null
            ? null
            : List<MovieResult>.from(json["results"].map((x) => MovieResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "total_results": totalResults == null ? null : totalResults,
        "total_pages": totalPages == null ? null : totalPages,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class MovieResult {
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  DateTime releaseDate;

  MovieResult({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  factory MovieResult.fromRawJson(String str) => MovieResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieResult.fromJson(Map<String, dynamic> json) => MovieResult(
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        id: json["id"] == null ? null : json["id"],
        video: json["video"] == null ? null : json["video"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        title: json["title"] == null ? null : json["title"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        genreIds: json["genre_ids"] == null
            ? null
            : List<int>.from(json["genre_ids"].map((x) => x)),
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        adult: json["adult"] == null ? null : json["adult"],
        overview: json["overview"] == null ? null : json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
      );

  Map<String, dynamic> toJson() => {
        "vote_count": voteCount == null ? null : voteCount,
        "id": id == null ? null : id,
        "video": video == null ? null : video,
        "vote_average": voteAverage == null ? null : voteAverage,
        "title": title == null ? null : title,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath == null ? null : posterPath,
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_title": originalTitle == null ? null : originalTitle,
        "genre_ids": genreIds == null
            ? null
            : List<dynamic>.from(genreIds.map((x) => x)),
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "adult": adult == null ? null : adult,
        "overview": overview == null ? null : overview,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
      };
}
