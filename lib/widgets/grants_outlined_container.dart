import 'package:flutter/material.dart';

class GrantsOutlinedContainer extends StatelessWidget {
  final Widget child;
  const GrantsOutlinedContainer({Key key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.1),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
