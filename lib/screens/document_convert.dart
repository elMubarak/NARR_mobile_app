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
      body: Center(
        child: Text(DocumentConvert.id),
      ),
    );
  }
}
