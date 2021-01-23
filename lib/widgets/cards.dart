import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard(
      {Key key,
      this.title,
      this.count,
      this.onTap,
      this.color,
      this.icon,
      this.info})
      : super(key: key);
  final String title;
  final String info;
  final String count;
  final Function onTap;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: Colors.white,
            border: Border.all(color: Colors.grey[200])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (title != null) ? title : '',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
