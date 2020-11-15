import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

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
      String contents = await file.readAsString();

      print('goten file => $contents');

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'empty';
    }
  }

  //write file:: test more
  Future<File> writeFile(var gotFile) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(gotFile);
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

String selectedfile;
String fileExtension;
String fileName;

class TestDownload {
  //pick file

  Future<String> selectDoc({
    List allowedExtensions,
  }) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      onFileLoading: (val) {
        if (val != null) {
          // do something
        }
      },
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      // itsAfile = result.files.first.bytes;
      fileName = result.files.first.name;
      selectedfile = result.files.first.path;
      fileExtension = result.files.first.extension;
      print('File Name $selectedfile');
      print('File Extension: $fileExtension');
    }
    return fileExtension;
  }

  checkFilePicked() {
    print('this ::=> $fileName');
  }

  getCOnvertedFile() async {
    String myTesturl = 'https://shamskhalil.ngrok.io/convert/office';
    var uri = Uri.parse(myTesturl);

    try {
      FormData formdata = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          selectedfile,
          filename: basename(selectedfile),
        ),
      });
      print(':: selected file $selectedfile');
      final response = await http.post(
        myTesturl,
        body: formdata.files.first,
      );
      if (response.contentLength == 0) {
        return;
      }
      Directory tempDir = await getExternalStorageDirectory();
      String tempPath = tempDir.path;
      File file = new File('$tempPath/savedFileW01.pdf');
      await file.writeAsBytes(response.bodyBytes);
      print(file);
    } catch (e) {
      print(e);
    }
  }
}
