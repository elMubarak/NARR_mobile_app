import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showLoginFlushbar(
    {required BuildContext context,
    required String message,
    required String user}) {
  Flushbar(
    title: "$user",
    icon: Icon(
      Icons.check_circle,
      color: Color(0xff00a368),
    ),
    leftBarIndicatorColor: Color(0xff00a368),
    // showProgressIndicator: true,
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // backgroundColor: Color(0xff00a368),
    message: "$message",
    duration: Duration(seconds: 5),
  )..show(context);
}

void showLogoutFlushbar(
    {required BuildContext context, required String message}) {
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
