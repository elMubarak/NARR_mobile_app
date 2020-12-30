import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSimpleFlushbar({BuildContext context, String message}) {
  print('show');
  Flushbar(
    title: "$message",
    icon: Icon(
      Icons.check_circle,
      color: Color(0xff00a368),
    ),
    leftBarIndicatorColor: Color(0xff00a368),
    // showProgressIndicator: true,
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // backgroundColor: Color(0xff00a368),
    message: "is now online",
    duration: Duration(seconds: 5),
  )..show(context);
}
