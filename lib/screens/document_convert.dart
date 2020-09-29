import 'package:flutter/material.dart';

class DocumentConvert extends StatefulWidget {
  static const String id = 'DocumentConvert';
  @override
  _DocumentConvertState createState() => _DocumentConvertState();
}

class _DocumentConvertState extends State<DocumentConvert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00a368),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 50.0,
              bottom: 30.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Converter Tool',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'All in one file converter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      DocumentServiceCard(
                        imagePath: 'images/pdf.png',
                        title: 'PDF to word',
                      ),
                      DocumentServiceCard(
                        imagePath: 'images/word.png',
                        title: 'Word to txt',
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: <Widget>[
                      DocumentServiceCard(
                        imagePath: 'images/excel.png',
                        title: 'Excel to PDF',
                      ),
                      DocumentServiceCard(
                        imagePath: 'images/txt.png',
                        title: 'Txt to PDF',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  DocumentServiceCard({this.imagePath, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Image.asset(
              imagePath,
              width: 70,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
