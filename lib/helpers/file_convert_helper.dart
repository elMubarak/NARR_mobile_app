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

// File pickedFile;
// List<int> bytes = [];
// int recieved = 0;
// int total = 0;

// class FileConvertHelper {
//   Future uploadDocument(
//       {String filePath,
//       String fileName,
//       String url,
//       BuildContext context}) async {
//     try {
//       final request = http.MultipartRequest('POST', Uri.parse(url));
//       request.files.add(
//         await http.MultipartFile.fromPath('file', filePath),
//       );
//       var res = await request.send();
//       //works at once
//       total = res.contentLength;
//       print('start size before write $recieved');
//       if (res.contentLength == 0) {
//         return res.contentLength;
//       }

//       String getDir = await ExtStorage.getExternalStorageDirectory();
//       String folderToSaveConver = 'Narr/Converted';
//       String fileToSave = fileName;
//       Directory fullFolderDirToSave = Directory('$getDir/$folderToSaveConver');

//       if (await fullFolderDirToSave.exists()) {
//         res.stream.listen(
//           (value) async {
//             bytes.addAll(value);
//             recieved += value.length;
//           },
//         ).onDone(() async {
//           final fileToWrite = File(
//             '${fullFolderDirToSave.path}/${fileToSave.split('.')[0]}.pdf',
//           );
//           await fileToWrite.writeAsBytes(bytes);
//           print('start size after write  $recieved');
//           print('total size $total');
//           pickedFile = fileToWrite;
//           if (recieved == total) {
//             print('ok');
//             // bytes.clear();
//             recieved = 0;
//           } else if (recieved < total) {
//             print('less bytes');
//           } else {
//             print('too much');
//           }
//         });

//         displayDialog(
//             context, "Success", "$fileName file converted successfully");
//         print('file path => ${pickedFile.path}');
//         print(
//             'status code ::==> ${res.statusCode} and reason phrase ::==> ${res.reasonPhrase}');
//       } else {
//         await fullFolderDirToSave.create(recursive: true);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
