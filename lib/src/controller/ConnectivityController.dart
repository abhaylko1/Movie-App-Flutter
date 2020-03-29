import 'dart:async';

import 'package:Movies/src/pages/NoInternetConnectivityPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Connection {
  Connection._();

  static bool isErrorShow = false;

  static StreamSubscription<ConnectivityResult> listenConnection(
      BuildContext context,
      {Color themeColor,
        TextStyle titleStyle,
        TextStyle notificationStyle}) {
    StreamSubscription<ConnectivityResult> subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!isErrorShow && result == ConnectivityResult.none) {
        _showError(context, themeColor, titleStyle, notificationStyle);
      } else {
        if (isErrorShow) {
          Navigator.pop(context);
          isErrorShow = false;
        }
      }
    });
    return subscription;
  }

  static _showError(BuildContext context, Color themeColor,
      TextStyle titleStyle, TextStyle notificationStyle) {
    isErrorShow = true;
    showModalBottomSheet(
        enableDrag: false,
        useRootNavigator: true,
        isDismissible: false,
        context: context,
        builder: (BuildContext bc) {
          return NoIntenetConnectivity();
        });
  }
}
