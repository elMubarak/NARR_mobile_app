import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DocToPDF {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/document.pdf');
  }

  //
  Future<int> readDoc() async {
    try {
      final file = await _localFile;
      print('file path ${_localFile.then((value) => print(value.path))}');
      // Read the file
      String contents = await file.readAsString();
      print('file content :: $contents');

      return int.parse(contents);
    } catch (e) {
      print('read file error :: $e');
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeDoc(var counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}
