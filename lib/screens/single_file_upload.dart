import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:narr/services/backend_service.dart';

class SingleFileUpload extends StatefulWidget {
  static const String id = 'SingleFileUpload';
  @override
  _SingleFileUploadState createState() => _SingleFileUploadState();
}

class _SingleFileUploadState extends State<SingleFileUpload> {
  static String topic;
  static String author;
  static String category;
  String baseUrl = 'http://192.168.43.219:3000/upload';
  bool flag = false;
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
      "authorName": '$author',
      "createDate": "2018-12-21 20:44:45.8"
    },
    "Topic": "$topic",
    "Category": "$category"
  };
  void onSendProgress(int sent, int total) {
    double percentage = (sent / total * 100);
    setState(() {
      bytesSent = sent;
      bytesTotal = total;
      progress = percentage;
      //update the progress
    });
  }

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
                        flag
                            ? ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: LinearProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  value: progress != null ? progress : 0,
                                ),
                                subtitle: Text(progress != null
                                    ? '$bytesSent of $bytesTotal'
                                    : ''),
                                trailing: Text(progress != null
                                    ? '${progress.toInt()} %'
                                    : ''),
                              )
                            : Container(),

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
                            hintText: 'Research Topic',
                            filled: true,
                          ),
                          onChanged: (value) {
                            topic = value;
                          },
                        ),
                        SizedBox(height: 14),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Author',
                            filled: true,
                          ),
                          onChanged: (value) {
                            author = value;
                          },
                        ),
                        SizedBox(height: 14),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Category',
                            filled: true,
                          ),
                          onChanged: (value) {
                            category = value;
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            flag = true;
                            // await _uploadFile();
                            await NetworkHelper(baseUrl).uploadFile(
                                response,
                                selectedfile,
                                uploadMeta,
                                onSendProgress,
                                context);
                          },
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
