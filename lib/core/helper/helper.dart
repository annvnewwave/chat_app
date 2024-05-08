import 'package:chat_app/core/router/app_router.dart';
import 'package:flutter/material.dart';

class Helper {
  static void showInSnackBar(String msg) {
    var snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }
}
