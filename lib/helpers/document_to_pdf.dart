import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DocToPDF {
  //get device dir
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }

//save file to dir
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/fileSAved2.pdf');
  }

  //read file
  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      var contents = await file.readAsString();

      print('goten file => $contents');

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'empty';
    }
  }

  //write file:: test more
  Future<File> writeFile(String gotFile) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(gotFile);
  }

  //
  void getPermission() async {
    print("getPermission");
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  //
  Future downloadFile(Dio dio, String url, String savePath) async {
    try {
      void showDownloadProgress(received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      }

      //
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }
}
