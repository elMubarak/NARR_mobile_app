import 'package:flutter/material.dart';

class OcrCard extends StatelessWidget {
  final IconData icon;
  final String cardTitle;
  const OcrCard({Key? key, required this.icon, required this.cardTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 35, bottom: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Color(0xff00a368),
          ),
          SizedBox(height: 3),
          Text(
            cardTitle,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xff00a368),
            ),
          ),
        ],
      ),
    );
  }
}
