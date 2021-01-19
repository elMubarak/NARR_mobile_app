import 'package:flutter/material.dart';

class SchoolDashCard extends StatelessWidget {
  const SchoolDashCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
          ),
        ],
      ),
    );
  }
}
