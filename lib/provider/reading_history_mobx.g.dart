// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_history_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReadingHistory on ReadingHistoryBase, Store {
  final _$readingHistoryDocumentAtom =
      Atom(name: 'ReadingHistoryBase.readingHistoryDocument');

  @override
  List<dynamic> get readingHistoryDocument {
    _$readingHistoryDocumentAtom.reportRead();
    return super.readingHistoryDocument;
  }

  @override
  set readingHistoryDocument(List<dynamic> value) {
    _$readingHistoryDocumentAtom
        .reportWrite(value, super.readingHistoryDocument, () {
      super.readingHistoryDocument = value;
    });
  }

  final _$ReadingHistoryBaseActionController =
      ActionController(name: 'ReadingHistoryBase');

  @override
  void getReadingHistory(List<dynamic> readingHistory) {
    final _$actionInfo = _$ReadingHistoryBaseActionController.startAction(
        name: 'ReadingHistoryBase.getReadingHistory');
    try {
      return super.getReadingHistory(readingHistory);
    } finally {
      _$ReadingHistoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
readingHistoryDocument: ${readingHistoryDocument}
    ''';
  }
}
