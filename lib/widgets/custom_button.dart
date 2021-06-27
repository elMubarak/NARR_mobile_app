import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String buttonTitle;
  final Color buttonColor;
  final VoidCallback onTap;
  final bool isLoading;
  CustomBotton(
      {required this.buttonTitle,
      required this.onTap,
      required this.isLoading,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? () {
              print('Loading!!!');
            }
          : onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 55,
          right: 55,
        ),
        decoration: BoxDecoration(
          color: (buttonColor == null)
              ? Color(0xff00a368)
              : (isLoading != null)
                  ? (isLoading)
                      ? Colors.grey
                      : buttonColor
                  : Color(0xff00a368),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2.5),
              blurRadius: 5,
              color: (isLoading != null)
                  ? (isLoading)
                      ? Colors.grey.withOpacity(0.3)
                      : Color(0xff00a368).withOpacity(0.3)
                  : Color(0xff00a368).withOpacity(0.3),
            ),
          ],
        ),
        child: (isLoading != null)
            ? (isLoading)
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    buttonTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )
            : Text(
                buttonTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
