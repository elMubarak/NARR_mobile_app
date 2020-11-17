import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:http/http.dart' as http;

class FileConvertHelper {
  uploadDocument({String filePath, String fileName, String url}) async {
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
      String folderName = 'Narr/converted';
      String savedFile = fileName;
      Directory fullPathToSave = Directory('$getDir/$folderName');
      Directory fileDir = fullPathToSave;
      if (await fullPathToSave.exists()) {
        File file = File('${fileDir.path}/$savedFile');
        var sink = file.openWrite();
        await res.stream.pipe(sink);
        sink.close();
        print('file path => ${file.path}');
      } else {
        await fileDir.create(recursive: true);
      }
    } catch (e) {
      print(e);
    }
  }
}
