import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:narr/helpers/document_to_pdf.dart';

class DocToPDFConvert extends StatefulWidget {
  static const String id = 'DocToPDFConvert';

  @override
  _DocToPDFConvertState createState() => _DocToPDFConvertState();
}

class _DocToPDFConvertState extends State<DocToPDFConvert> {
  final testFile =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  DocToPDF docToPDF = DocToPDF();
  Dio dio = Dio();
  @override
  void initState() {
    docToPDF.getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
