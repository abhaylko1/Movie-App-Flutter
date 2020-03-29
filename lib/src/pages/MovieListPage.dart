import 'dart:async';

import 'package:Movies/src/controller/ConnectivityController.dart';
import 'package:Movies/src/controller/MovieListController.dart';
import 'package:Movies/src/modules/MovieList.dart';
import 'package:Movies/src/pages/MovieDetailPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovieListPageState();
  }
}

class _MovieListPageState extends State<MovieListPage> {
  String IMAGE_PATH_URL = 'https://image.tmdb.org/t/p/w1280';
  StreamSubscription connectivity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Connection.listenConnection(context);
    connectivity = Connection.listenConnection(context);
    connectivity.onData((data) {
      if (data != ConnectivityResult.none) {
        movieListController.getAllMovieList();
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    movieListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: movieListController.movieList,
        builder: (context, AsyncSnapshot<MovieList> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.results.length > 0) {
              return buildMovieListWidget(snapshot);
            } else {
              return Center(
                child: Text(
                  "No Movie Found",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildMovieListWidget(AsyncSnapshot<MovieList> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.results.length,
      itemBuilder: (BuildContext context, int index) {
        return _makeListView(snapshot.data.results[index]);
      },
    );
  }

  _makeListView(MovieResult result) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(result.title),
          subtitle: Text(result.title),
          leading: Container(
            child: Image.network(
              '$IMAGE_PATH_URL${result.posterPath}',
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailPage(
                        id: result.id.toString(),
                        result: result,
                      )));
        });
      },
    );
  }
}
