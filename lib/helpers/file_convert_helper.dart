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
      String folderToSave = 'Narr/Converted';
      String fileToSave = fileName;
      Directory fullFolderDirToSave = Directory('$getDir/$folderToSave');

      if (await fullFolderDirToSave.exists()) {
        File file =
            File('${fullFolderDirToSave.path}/${fileToSave.split('.')[0]}.pdf');
        var sink = file.openWrite();
        await res.stream.pipe(sink);
        sink.close();

        print('file path => ${file.path}');
      } else {
        await fullFolderDirToSave.create(recursive: true);
      }
      print(res.contentLength);
      // int fileSize = res.contentLength;
      // List<int> progress = [await res.stream.length];
      // String downlodProgress = '$progress of $fileSize';
    } catch (e) {
      print(e);
    }
  }
}
