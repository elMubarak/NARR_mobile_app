import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolDashCard extends StatelessWidget {
  const SchoolDashCard({
    Key key,
    this.institutionName,
    this.institutionLogo,
    this.institutionAcronym,
    this.studentNo,
    this.onTap,
    this.institutionType,
    this.institutionYear,
    this.institutionUrl,
  }) : super(key: key);
  final String institutionName;
  final String institutionType;
  final String institutionYear;
  final String institutionUrl;
  final String institutionLogo;
  final String institutionAcronym;
  final int studentNo;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          (institutionLogo != null) ? institutionLogo : ''),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Divider(thickness: 1.3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (institutionName != null) ? institutionName : '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    (institutionAcronym != null) ? '($institutionAcronym)' : '',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Text(
                        (institutionType != null) ? '$institutionType' : '',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        (institutionYear != null) ? '$institutionYear' : '',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          launch(institutionUrl);
                        },
                        child: Text(
                          (institutionUrl != null) ? '$institutionUrl' : '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
