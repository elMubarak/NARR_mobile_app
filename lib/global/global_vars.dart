import 'package:flutter/material.dart';
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/admin_dash/admin_dash.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/investor_dash/investor_dasboard.dart';
import 'package:narr/screens/sponsor_dash/sponsor_dashboard.dart';

String userRole = '';
UserModel currentUser;

void determineDasboard(BuildContext context) {
  if (currentUser != null) {
    if (currentUser.userRole == 'researcher') {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    } else if (currentUser.userRole == 'admin') {
      Navigator.pushReplacementNamed(context, AdminDashBoard.id);
    } else if (currentUser.userRole == 'investor') {
      Navigator.pushReplacementNamed(context, InvestorDashboard.id);
    } else if (currentUser.userRole == 'Sponsor') {
      Navigator.pushReplacementNamed(context, SponsorDashboard.id);
    }
  }
}

Color determinePrimaryColor(context) {
  if (currentUser != null) {
    if (currentUser.userRole == 'researcher') {
      return Color(0xff00a368);
    } else if (currentUser.userRole == 'admin') {
      return Colors.lightBlue;
    } else if (currentUser.userRole == 'investor') {
      return Colors.yellow;
    } else if (currentUser.userRole == 'investor') {
      return Colors.red;
    }
  } else {
    return Color(0xff00a368);
  }
  return Color(0xff00a368);
}
