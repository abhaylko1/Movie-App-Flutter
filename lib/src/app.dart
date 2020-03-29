import 'package:Movies/src/controller/ConnectivityController.dart';
import 'package:Movies/src/pages/MovieListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Flutter App',
      theme: ThemeData.light(),
      home: MovieListPage(),
    );
  }
}
