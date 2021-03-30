// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_flush_bar_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShowFlushBar on ShowFlushBarBase, Store {
  final _$fullNameAtom = Atom(name: 'ShowFlushBarBase.fullName');

  @override
  String get fullName {
    _$fullNameAtom.reportRead();
    return super.fullName;
  }

  @override
  set fullName(String value) {
    _$fullNameAtom.reportWrite(value, super.fullName, () {
      super.fullName = value;
    });
  }

  final _$ShowFlushBarBaseActionController =
      ActionController(name: 'ShowFlushBarBase');

  @override
  void updatedUserFlushBar({String userFullName, String userMessage}) {
    final _$actionInfo = _$ShowFlushBarBaseActionController.startAction(
        name: 'ShowFlushBarBase.updatedUserFlushBar');
    try {
      return super.updatedUserFlushBar(
          userFullName: userFullName, userMessage: userMessage);
    } finally {
      _$ShowFlushBarBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fullName: ${fullName}
    ''';
  }
}
