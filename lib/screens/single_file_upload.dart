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
  String baseUrl = 'http://192.168.43.219:3000/upload';

  static DateTime dateTime = DateTime.now();
  static TextEditingController topicController = TextEditingController();
  static TextEditingController authorController = TextEditingController();
  static TextEditingController categoryController = TextEditingController();
  //
  Dio dio = Dio();
  bool flag = false;
  String selectedfile;
  String fileExtension;
  String fileName;
  Response response;
  double progress;
  int bytesSent;
  int bytesTotal;

  Map uploadMeta = {
    "Author": {
      "authorId": "298",
      "authorName": '${authorController.text}',
      "createDate": "${dateTime.toIso8601String()}" //hrs
    },
    "Topic": "${topicController.text}",
    "Category": "${categoryController.text}"
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
      onFileLoading: (val) {
        if (val != null) {
          // do something
        }
      },
      type: FileType.custom,
      allowedExtensions: [
        'docx',
        'pdf',
        'txt',
        'doc',
        'odt',
        'odp',
        'rtf',
        'pptx',
        'ppt',
        'html',
      ],
    );

    if (result != null) {
      fileName = result.files.first.name;
      selectedfile = result.files.first.path;
      fileExtension = result.files.first.extension;
      print('File Name $selectedfile');
      print('File Extension :: $fileExtension');
      setState(() {});
    }
    return fileExtension;
  }

//drop file
  void dropFile() {
    fileName = null;
    fileExtension = null;
    selectedfile = null;
    setState(() {
      flag = false;
    });
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
            'Upload',
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$fileName',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () => dropFile(),
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        //
                        TextField(
                          controller: topicController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Research Topic',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 14),
                        TextField(
                          controller: authorController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Author',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 14),
                        TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Category',
                            filled: true,
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            flag = true;
                            // await _uploadFile();
                            await NetworkHelper(baseUrl).uploadFile(
                                response: response,
                                selectedfile: selectedfile,
                                uploadMeta: uploadMeta,
                                onSendProgress: onSendProgress,
                                context: context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _selectDoc();
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.file_upload,
                          color: Color(0xff00a368),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Recent Uploads:'),
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                        ListTile(
                          title: Text('SCM intergration'),
                          subtitle: Text('12/12/2020'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
