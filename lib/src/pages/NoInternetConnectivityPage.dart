import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoIntenetConnectivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoIntenetConnectivity();
  }
}

class _NoIntenetConnectivity extends State<NoIntenetConnectivity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Some error occurred",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
