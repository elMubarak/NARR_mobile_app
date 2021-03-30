// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_users_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OnlineUsers on OnlineUsersBase, Store {
  final _$numberOfUsersOnlineAtom =
      Atom(name: 'OnlineUsersBase.numberOfUsersOnline');

  @override
  List<dynamic> get numberOfUsersOnline {
    _$numberOfUsersOnlineAtom.reportRead();
    return super.numberOfUsersOnline;
  }

  @override
  set numberOfUsersOnline(List<dynamic> value) {
    _$numberOfUsersOnlineAtom.reportWrite(value, super.numberOfUsersOnline, () {
      super.numberOfUsersOnline = value;
    });
  }

  final _$OnlineUsersBaseActionController =
      ActionController(name: 'OnlineUsersBase');

  @override
  void getNumberOfUsersOnline(List<dynamic> usersOnline) {
    final _$actionInfo = _$OnlineUsersBaseActionController.startAction(
        name: 'OnlineUsersBase.getNumberOfUsersOnline');
    try {
      return super.getNumberOfUsersOnline(usersOnline);
    } finally {
      _$OnlineUsersBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
numberOfUsersOnline: ${numberOfUsersOnline}
    ''';
  }
}
