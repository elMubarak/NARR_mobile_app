import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'show_flush_bar_mobx.g.dart';

class ShowFlushBar = ShowFlushBarBase with _$ShowFlushBar;

abstract class ShowFlushBarBase with Store {
  @observable
  String fullName = '';
  String message = '';
  BuildContext context;

  @action
  void updatedUserFlushBar({String userFullName, String userMessage}) {
    print(userFullName);
    print(userMessage);
  }
}
