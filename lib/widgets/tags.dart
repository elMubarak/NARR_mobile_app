import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String tagTitle;
  const Tag({this.tagTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(tagTitle),
    );
  }
}
