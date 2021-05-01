import 'package:flutter/material.dart';

class InvestorDashboard extends StatefulWidget {
  static const String id = 'InvestorDashboard';
  @override
  _InvestorDashboardState createState() => _InvestorDashboardState();
}

class _InvestorDashboardState extends State<InvestorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Investor'),
      ),
    );
  }
}
