// To parse this JSON data, do
//
//     final movieDetails = movieDetailsFromJson(jsonString);

import 'dart:convert';

class MovieDetail {
  int id;
  List<MovieDetailResult> results;

  MovieDetail({
    this.id,
    this.results,
  });

  factory MovieDetail.fromRawJson(String str) =>
      MovieDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        id: json["id"] == null ? null : json["id"],
        results: json["results"] == null
            ? null
            : List<MovieDetailResult>.from(json["results"].map((x) => MovieDetailResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class MovieDetailResult {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  MovieDetailResult({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  factory MovieDetailResult.fromRawJson(String str) => MovieDetailResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieDetailResult.fromJson(Map<String, dynamic> json) => MovieDetailResult(
        id: json["id"] == null ? null : json["id"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
        key: json["key"] == null ? null : json["key"],
        name: json["name"] == null ? null : json["name"],
        site: json["site"] == null ? null : json["site"],
        size: json["size"] == null ? null : json["size"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "iso_3166_1": iso31661 == null ? null : iso31661,
        "key": key == null ? null : key,
        "name": name == null ? null : name,
        "site": site == null ? null : site,
        "size": size == null ? null : size,
        "type": type == null ? null : type,
      };
}
