import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  // String userName = '';
  // String message = '';

  // void updatedUserLogInEvent({String user, context, String msg}) {
  //   userName = user;
  //   showLoginFlushbar(context: context, user: user, message: msg);

  //   notifyListeners();
  // }

  // String usersLogOutEvent = '';
  // void updatedUserOutEvent({String usersEvent, context}) {
  //   usersLogOutEvent = usersEvent;
  //   showLogoutFlushbar(context: context, message: usersEvent);

  //   notifyListeners();
  // }

  // String userToken;
  // dynamic userObject;
  // void getUserToken({String token}) async {
  //   var userStore = await Hive.openBox('local-user');
  //   userToken = token;
  //   userObject = userStore.get('user');
  //   notifyListeners();
  // }

  late Map<String, dynamic> analyticObj;
  void getAnalyticsStream({dynamic analytics, context}) {
    analyticObj = {
      "usersOnline": analytics['usersOnline'],
      "readingHistory": analytics['readingHistory'],
      "trending": analytics['trending']
    };

    notifyListeners();
  }
}
