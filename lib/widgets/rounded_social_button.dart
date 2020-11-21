import 'package:flutter/material.dart';

class RoundedSocialButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color iconColor;
  const RoundedSocialButton({this.icon, this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      elevation: 4.0,
      disabledElevation: 4.0,
      fillColor: Colors.white,
      constraints: BoxConstraints(minWidth: 34.0, minHeight: 34.0),
      child: Icon(
        icon,
        size: 18,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}
