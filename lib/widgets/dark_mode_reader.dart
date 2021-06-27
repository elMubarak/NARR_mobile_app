library invert_colors;

import 'package:flutter/widgets.dart';

class DarkNight extends StatelessWidget {
  final Widget child;

  const DarkNight({required this.child});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix([
        -1, //RED
        0,
        0,
        0,
        255, //GREEN
        0,
        -1,
        0,
        0,
        255, //BLUE
        0,
        0,
        -1,
        0,
        255, //ALPHA
        0,
        0,
        0,
        1,
        0,
      ]),
      child: this.child,
    );
  }
}
