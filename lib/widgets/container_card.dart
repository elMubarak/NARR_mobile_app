import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
  final Widget child;
  ContainerCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: 15,
        right: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.4),
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.25),
          ),
        ],
      ),
      child: child,
    );
  }
}
