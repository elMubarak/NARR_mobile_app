import 'dart:async';
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
  List<int> bytes = [];
  int recieved = 0;
  int total = 0;

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
      total = res.contentLength;
      print('start size before sink $recieved');
      if (res.contentLength == 0) {
        return res.contentLength;
      } else {
        String getDir = await ExtStorage.getExternalStorageDirectory();
        String folderToSaveConver = 'Narr/Converted';
        String fileToSave = fileName;
        Directory fullFolderDirToSave =
            Directory('$getDir/$folderToSaveConver');

        if (await fullFolderDirToSave.exists()) {
          File file = File(
              '${fullFolderDirToSave.path}/${fileToSave.split('.')[0]}.pdf');

          // var sink = file.openWrite();
          // await fileStream.pipe(sink);
          // sink.close();
          res.stream.listen(
            (value) {
              bytes.addAll(value);
              recieved += value.length;
            },
          ).onDone(() async {
            final file = File(
              '${fullFolderDirToSave.path}/${fileToSave.split('.')[0]}.pdf',
            );
            await file.writeAsBytes(bytes);
            print('start size during sink  $recieved');
          });
          displayDialog(
              context, "Success", "$fileName file converted successfully");
          print('file path => ${file.path}');
          print('start size after sink $recieved');

          print(
              'status code ::==> ${res.statusCode} and reason phrase ::==> ${res.reasonPhrase}');
        } else {
          await fullFolderDirToSave.create(recursive: true);
        }
        return res.contentLength;
      }
    } catch (e) {
      print(e);
    }
  }
}
