import 'package:mobx/mobx.dart';

part 'reading_history_mobx.g.dart';

class ReadingHistory = ReadingHistoryBase with _$ReadingHistory;

abstract class ReadingHistoryBase with Store {
  @observable
  List readingHistoryDocument = [];

  @action
  void getReadingHistory(List readingHistory) {
    readingHistoryDocument = readingHistory;
  }
}
