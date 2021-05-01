import 'package:flutter/material.dart';

class SponsorDashboard extends StatefulWidget {
  static const String id = 'SponsorDashboard';
  @override
  _SponsorDashboardState createState() => _SponsorDashboardState();
}

class _SponsorDashboardState extends State<SponsorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Sponsor Dash'),
      ),
    );
  }
}
