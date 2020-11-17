import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

String myTesturl = 'https://shamskhalil.ngrok.io/convert/office';
String localUrl = 'http://192.168.43.70:3000/convert';

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
      Directory dir = await getExternalStorageDirectory();
      String path = dir.path;
      File file = File('$path/$fileName'); //.pdf to emulate convert
      print(file.path);
      var sink = file.openWrite();
      await res.stream.pipe(sink);
      sink.close();
    } catch (e) {
      print(e);
    }
  }
}
