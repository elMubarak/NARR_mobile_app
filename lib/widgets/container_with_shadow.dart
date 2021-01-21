import 'package:flutter/material.dart';

class ContainerWithShadow extends StatelessWidget {
  final Widget child;
  const ContainerWithShadow({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }
}
