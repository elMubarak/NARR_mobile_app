import 'package:flutter/material.dart';
import 'package:narr/models/repository_model.dart';
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/admin_dash/admin_dash.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/investor_dash/investor_dasboard.dart';
import 'package:narr/screens/sponsor_dash/sponsor_dashboard.dart';
import 'package:narr/store/hive_store.dart';

String userRole = '';
UserModel currentUser;
RepositoryModel repositoryModel;
ProcessModel currentProccess;
List<ProcessModel> processes = <ProcessModel>[];
HiveBox _box = HiveBox();

String determineDasboard(BuildContext context) {
  if (currentUser != null) {
    if (currentUser.userRole == 'researcher') {
      return HomeScreen.id;
    } else if (currentUser.userRole == 'admin') {
      return AdminDashBoard.id;
    } else if (currentUser.userRole == 'investor') {
      return InvestorDashboard.id;
    } else if (currentUser.userRole == 'Sponsor') {
      return SponsorDashboard.id;
    } else {
      return HomeScreen.id;
    }
  }
  return HomeScreen.id;
}

Color determinePrimaryColor(context) {
  if (currentUser != null) {
    if (currentUser.userRole == 'researcher') {
      return Color(0xff00a368);
    } else if (currentUser.userRole == 'admin') {
      return Colors.lightBlue;
    } else if (currentUser.userRole == 'investor') {
      return Colors.yellow;
    } else if (currentUser.userRole == 'Sponsor') {
      return Colors.red;
    }
  } else {
    return Color(0xff00a368);
  }
  return Color(0xff00a368);
}

//
Future getStoredUserObject() async {
  Map<String, dynamic> savedUser = await _box.getSavedUser();
  return savedUser;
}
