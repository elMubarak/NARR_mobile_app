import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushSnackBar extends StatelessWidget {
  FlushSnackBar(
      this.message, this.title, this.color, this.bandColor, this.show);
  final String message;
  final String title;
  final Color color;
  final Color bandColor;
  final Function show;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flushbar(
        title: (title != null) ? title : '',
        message: (message != null) ? message : '',
        backgroundColor: (color != null) ? color : Colors.white,
        leftBarIndicatorColor:
            (bandColor != null) ? bandColor : Color(0xff00a368),
      ),
    );
  }
}
