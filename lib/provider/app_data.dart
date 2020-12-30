import 'package:flutter/material.dart';
import 'package:narr/widgets/flush_snackbar.dart';

class AppData extends ChangeNotifier {
  String usersLogInEvent = '';
  void updatedUserLogInEvent({String usersEvent, context}) {
    usersLogInEvent = usersEvent;
    showSimpleFlushbar(context: context, message: usersEvent);
    print('here user data $usersEvent');

    notifyListeners();
  }
}
