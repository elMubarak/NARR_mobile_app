import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'show_flush_bar_mobx.g.dart';

class ShowFlushBar = ShowFlushBarBase with _$ShowFlushBar;

abstract class ShowFlushBarBase with Store {
  @observable
  String fullName = '';
  String message = '';
  late BuildContext context;

  @action
  void updatedUserFlushBar(
      {required String userFullName, required String userMessage}) {
    print(userFullName);
    print(userMessage);
  }
}
