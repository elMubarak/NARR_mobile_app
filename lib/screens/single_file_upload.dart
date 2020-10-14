import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class SingleFileUpload extends StatefulWidget {
  static const String id = 'SingleFileUpload';
  @override
  _SingleFileUploadState createState() => _SingleFileUploadState();
}

class _SingleFileUploadState extends State<SingleFileUpload> {
  String baseUrl = 'http://192.168.43.70:3000/upload';

  String selectedfile;
  String fileExtension;
  String fileName;
  Dio dio = new Dio();
  Response response;
  double progress;
  int bytesSent;
  int bytesTotal;
  Map uploadMeta = {
    "Author": {
      "authorId": "298",
      "authorName": "Mubarak",
      "createDate": "2018-12-21 20:44:45.8"
    },
    "Topic": "Some awesome research",
    "Category": "Grant"
  };

//pick file
  Future<String> _selectDoc() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf', 'txt', 'doc'],
    );

    if (result != null) {
      fileName = result.files.first.name;
      selectedfile = result.files.first.path;
      print(selectedfile);
      print(fileExtension);
      setState(() {});
    }
    return fileExtension;
  }

  //upload process
  _uploadFile() async {
    String uploadurl = baseUrl;
    FormData formdata = FormData.fromMap({
      "meta": uploadMeta,
      "file": await MultipartFile.fromFile(selectedfile,
          filename: basename(selectedfile)),
    });

    response = await dio.post(
      uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        double percentage = (sent / total * 100);
        setState(() {
          bytesSent = sent;
          bytesTotal = total;
          progress = percentage;
          //update the progress
        });
      },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey[600],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Single Upload',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          )),
      body: selectedfile != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2.5),
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: LinearProgressIndicator(
                            backgroundColor: Colors.grey,
                            value: progress != null ? progress : 0,
                          ),
                          subtitle: Text(progress != null
                              ? '$bytesSent of $bytesTotal'
                              : ''),
                          trailing: Text(
                              progress != null ? '${progress.toInt()} %' : ''),
                        ),

                        SizedBox(height: 10),

                        Text(
                          '$fileName',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        //
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Topic',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 14),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Author',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 14),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Category',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: _uploadFile,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 18,
                              right: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff00a368),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Upload',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                _selectDoc();
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          'Click the upload file \n button to start \n upload proccess.',
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.grey[900].withOpacity(0.25),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Icon(
                      Icons.file_upload,
                      color: Color(0xff00a368),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
