import 'dart:async';

import 'package:Movies/src/controller/ConnectivityController.dart';
import 'package:Movies/src/controller/MovieDetailController.dart';
import 'package:Movies/src/modules/MovieDetail.dart';
import 'package:Movies/src/modules/MovieList.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final String id;
  final MovieResult result;

  MovieDetailPage({this.id, this.result});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailPage();
  }
}

class _MovieDetailPage extends State<MovieDetailPage> {
  String IMAGE_PATH_URL = 'https://image.tmdb.org/t/p/w1280';
  StreamSubscription connectivity;

  @override
  void didChangeDependencies() {
    movieDetailController.getMovieDetail(widget.id);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    connectivity = Connection.listenConnection(context);
    connectivity.onData((data) {
      if (data != ConnectivityResult.none) {
        movieDetailController.getMovieDetail(widget.id);
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: StreamBuilder(
        stream: movieDetailController.movieDetail,
        builder: (context, AsyncSnapshot<MovieDetail> snapshot) {
          if (snapshot.hasData) {
            return buildMovieDetailWidget(snapshot.data.results);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  buildMovieDetailWidget(List<MovieDetailResult> trailers) {
    return Stack(
      children: <Widget>[
        _buildCoverImage(),
        Container(
          height: MediaQuery.of(context).size.height / 1.9,
          width: double.infinity,
          child: _buildProfileImage(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 300),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      SafeArea(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            _buildTitle(),
                            sizeBox(20),
                            Divider(color: Colors.black),
                            _buildDetails(),
                            Divider(color: Colors.black),
                            _buildLanguage(),
                            _buildIsAdult(),
                            Divider(color: Colors.black),
                            sizeBox(20),
                            _buildOverview(),
                            Divider(color: Colors.black),
                            sizeBox(20),
                            _buildTrailers(trailers),
                            Divider(color: Colors.black),
                            sizeBox(20)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCoverImage() {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.network(
              '$IMAGE_PATH_URL${widget.result.backdropPath}',
            ).image,
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.height / 5,
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(
              '$IMAGE_PATH_URL${widget.result.posterPath}',
            ).image,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        widget.result.originalTitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget sizeBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _buildDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildPopularity(),
        _buildAverageRate(),
        _buildVoteCount(),
        _buildReleaseDate(),
      ],
    );
  }

  Widget _buildPopularity() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 26,
        ),
        Text("Popularity"),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            widget.result.popularity.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildReleaseDate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.date_range,
          color: Colors.red,
          size: 26,
        ),
        Text("Release Date"),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            widget.result.releaseDate.day.toString() +
                "-" +
                widget.result.releaseDate.month.toString() +
                "-" +
                widget.result.releaseDate.year.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildLanguage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.language,
          color: Colors.red,
          size: 26,
        ),
        Text("Language : "),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            widget.result.originalLanguage,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildIsAdult() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("For Adults only : "),
        Padding(
            padding: EdgeInsets.only(left: 5),
            child: widget.result.adult
                ? Text(
                    "Yes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                : Text("No",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
      ],
    );
  }

  Widget _buildAverageRate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.red,
          size: 26,
        ),
        Text("Rate"),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            widget.result.voteAverage.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildVoteCount() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.show_chart,
          color: Colors.red,
          size: 26,
        ),
        Text("Votes"),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            widget.result.voteCount.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildOverview() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              "Overview ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.brown),
            ),
          ),
          sizeBox(10),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.result.overview,
              overflow: TextOverflow.visible,
              style: TextStyle(fontSize: 18),
            ),
          )
        ]);
  }

  Widget _buildTrailers(List<MovieDetailResult> trailers) {
    print(trailers);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              "Trailer's",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.brown),
            ),
          ),
          sizeBox(10),
          (trailers.length > 0)
              ? Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(
                    child: _buildTrailerWidget(trailers),
                    height: 110,
                  ),
                )
              : Center(
                  child: Text(
                    "No Trailer available",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )
        ]);
  }

  Widget _buildTrailerWidget(List<MovieDetailResult> trailers) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return VerticalDivider(color: Colors.black, width: 20);
      },
      itemCount: trailers.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _buildTrailer(trailers[index]);
      },
    );
  }

  Widget _buildTrailer(MovieDetailResult movie) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 30, top: 10),
            child: Center(
                child: Icon(
              Icons.play_circle_outline,
              color: Colors.black,
            )),
          ),
          Text(
            movie.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
