import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final Widget child;
  FormCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: child,
    );
  }
}
