import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard(
      {Key key, this.title, this.count, this.onTap, this.color, this.icon})
      : super(key: key);
  final String title;
  final String count;
  final Function onTap;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2.5),
              blurRadius: 8,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: color,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 2),
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
