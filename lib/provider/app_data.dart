import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:narr/widgets/flush_snackbar.dart';

class AppData extends ChangeNotifier {
  String userName = '';
  String message = '';

  void updatedUserLogInEvent({String user, context, String msg}) {
    userName = user;
    showLoginFlushbar(context: context, user: user, message: msg);

    notifyListeners();
  }

  String usersLogOutEvent = '';
  void updatedUserOutEvent({String usersEvent, context}) {
    usersLogOutEvent = usersEvent;
    showLogoutFlushbar(context: context, message: usersEvent);

    notifyListeners();
  }

  String userToken;
  dynamic userObject;
  void getUserToken() async {
    var userStore = await Hive.openBox('local-user');
    userToken = userStore.get('token');
    userObject = userStore.get('user');
    notifyListeners();
  }

  List usersOnlineList = [];
  void updatedUsersOnline({dynamic usersOnline, context}) {
    usersOnlineList = usersOnline;
    notifyListeners();
  }
}
