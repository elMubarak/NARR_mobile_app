import 'package:flutter/material.dart';

class OCRScreen extends StatefulWidget {
  static const String id = 'OCRScreen';
  @override
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(OCRScreen.id),
      ),
    );
  }
}
