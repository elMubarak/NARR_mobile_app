import 'package:flutter/material.dart';

class RoundedSocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  const RoundedSocialButton(
      {required this.icon, required this.onPressed, required this.iconColor});

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
