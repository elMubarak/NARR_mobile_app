import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String buttonTitle;
  CustomBotton({this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 55,
        right: 55,
      ),
      decoration: BoxDecoration(
        color: Color(0xff00a368),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            blurRadius: 5,
            color: Color(0xff00a368).withOpacity(0.3),
          ),
        ],
      ),
      child: Text(
        buttonTitle,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
