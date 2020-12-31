import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showLoginFlushbar({BuildContext context, String message}) {
  Flushbar(
    title: "$message",
    icon: Icon(
      Icons.check_circle,
      color: Color(0xff00a368),
    ),
    leftBarIndicatorColor: Colors.white,
    // showProgressIndicator: true,
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // backgroundColor: Color(0xff00a368),
    message: "is now online",
    duration: Duration(seconds: 5),
  )..show(context);
}

void showLogoutFlushbar({BuildContext context, String message}) {
  Flushbar(
    title: "$message",
    icon: Icon(
      Icons.info,
      color: Color(0xfffcda44),
    ),
    leftBarIndicatorColor: Color(0xfffcda44),
    // showProgressIndicator: true,
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // backgroundColor: Color(0xff00a368),
    message: "is now offline",
    duration: Duration(seconds: 5),
  )..show(context);
}
