import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DocToPDFConvert extends StatefulWidget {
  static const String id = 'DocToPDFConvert';

  @override
  _DocToPDFConvertState createState() => _DocToPDFConvertState();
}

class _DocToPDFConvertState extends State<DocToPDFConvert> {
  Dio dio = Dio();
  @override
  void initState() {
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
