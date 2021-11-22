import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlushbarUtils {
  void showSuccessFlushbar(String title, String message, BuildContext context) {
    Flushbar(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void showNeutralFlusbar(String title, String message, BuildContext context) {
    Flushbar(
      title: title,
      message: message,
      backgroundColor: Colors.grey,
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void showErrorFlushbar(String title, String message, BuildContext context) {
    Flushbar(
      title: title,
      message: message,
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
