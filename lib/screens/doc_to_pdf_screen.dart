import 'dart:io';

import 'package:flutter/material.dart';
import 'package:narr/helpers/document_to_pdf.dart';

class DocToPDFConvert extends StatefulWidget {
  static const String id = 'DocToPDFConvert';

  @override
  _DocToPDFConvertState createState() => _DocToPDFConvertState();
}

class _DocToPDFConvertState extends State<DocToPDFConvert> {
  DocToPDF docToPDF = DocToPDF();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hello'),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  docToPDF.writeDoc('Hello mubixy how are you');
                },
                child: Text('Write'),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  docToPDF.readDoc();
                },
                child: Text('read'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
