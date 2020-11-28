import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
      ),
    );

class FileConvertHelper {
  Future uploadDocument(
      {String filePath,
      String fileName,
      String url,
      BuildContext context}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
        await http.MultipartFile.fromPath('file', filePath),
      );
      var res = await request.send();
      if (res.contentLength == 0) {
        return;
      }
      String getDir = await ExtStorage.getExternalStorageDirectory();
      String folderToSaveConver = 'Narr/Converted';
      String fileToSave = fileName;
      Directory fullFolderDirToSave = Directory('$getDir/$folderToSaveConver');

      if (await fullFolderDirToSave.exists()) {
        File file =
            File('${fullFolderDirToSave.path}/${fileToSave.split('.')[0]}.pdf');
        var sink = file.openWrite();
        await res.stream.pipe(sink);
        sink.close();
        displayDialog(
            context, "Success", "$fileName file converted successfully");
        print('file path => ${file.path}');
        print(res.contentLength);
        print(
            'status code ::==> ${res.statusCode} and reason phrase ::==> ${res.reasonPhrase}');
      } else {
        await fullFolderDirToSave.create(recursive: true);
      }
      // int fileSize = res.contentLength;
      // List<int> progress = [await res.stream.length];
      // String downlodProgress = '$progress of $fileSize';
    } catch (e) {
      print(e);
    }
  }
}
