import 'package:flutter/material.dart';
import 'package:narr/services/url_luncher.dart';

class SchoolDashCard extends StatelessWidget {
  const SchoolDashCard({
    Key key,
    this.institutionName,
    this.institutionLogo,
    this.institutionAcronym,
    this.institutionType,
    this.year,
    this.onTap,
    this.ownerShip,
    this.url,
  });
  final String institutionName;
  final String institutionLogo;
  final String institutionAcronym;
  final String institutionType;
  final String year, ownerShip, url;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      (institutionAcronym != null)
                          ? '($institutionAcronym)'
                          : '',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
            Divider(thickness: 1.3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (institutionType != null) ? 'Type: $institutionType' : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  (year != null) ? 'Year: $year' : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  (ownerShip != null) ? 'Ownership: $ownerShip' : '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () => launchURL(url),
                  child: Row(
                    children: [
                      Text(
                        'Link: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        (url != null) ? '$url' : '',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                        ),
                      ),
                    ],
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
