import 'package:flutter/material.dart';

class SchoolDashCard extends StatelessWidget {
  const SchoolDashCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Ahmadu Bello University,Zaria',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            '(ABU)',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
