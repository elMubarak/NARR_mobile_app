import 'package:flutter/material.dart';

class SchoolDashCard extends StatelessWidget {
  const SchoolDashCard({
    Key key,
    this.institutionName,
    this.institutionLogo,
    this.institutionAcronym,
    this.studentNo,
    this.onTap,
  }) : super(key: key);
  final String institutionName;
  final String institutionLogo;
  final String institutionAcronym;
  final int studentNo;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                backgroundImage: NetworkImage(
                    (institutionLogo != null) ? institutionLogo : ''),
              ),
            ),
            SizedBox(height: 10),
            Text(
              (institutionName != null) ? institutionName : '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              (institutionAcronym != null) ? '($institutionAcronym)' : '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(height: 10),
            Text(
              (studentNo != null) ? 'Students: $studentNo' : '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
