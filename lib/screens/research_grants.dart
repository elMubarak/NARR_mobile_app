import 'package:flutter/material.dart';

class ResearchGrants extends StatefulWidget {
  static String id = 'research';
  @override
  _ResearchGrantsState createState() => _ResearchGrantsState();
}

class _ResearchGrantsState extends State<ResearchGrants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          ResearchGrants.id,
        ),
      ),
    );
  }
}
