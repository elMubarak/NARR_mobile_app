import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SingleFileUpload extends StatefulWidget {
  static const String id = 'SingleFileUpload';
  @override
  _SingleFileUploadState createState() => _SingleFileUploadState();
}

class _SingleFileUploadState extends State<SingleFileUpload> {
  bool isUploading = false;
  bool isLoading = false;

  File _document;
  PlatformFile _documentInfo;
  String extensionName;
  String fileName;
  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'txt', 'docx'],
    );

    if (result != null) {
      setState(() {
        _document = File(result.files.first.path);
        _documentInfo = result.files.first;
        extensionName = _documentInfo.extension;
        fileName = _documentInfo.name;
        print('the extension ${extensionName ?? extensionName}');
        print('the doc $_document');
        if (fileName != null)
          setState(() {
            isUploading = true;
            isLoading = false;
          });
      });
    } else {
      print('file is null');
    }
  }

  bool isReady = false;
  rebuildTree() {
    setState(() {
      isReady = false;
    });
    print('called');
  }

  @override
  Widget build(BuildContext context) {
    rebuildTree();
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
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(strokeWidth: 10),
                  SizedBox(height: 25),
                  Text(
                    'Please Wait ...',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 70,
                      margin: EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                        bottom: 5,
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2.5),
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Center(
                        child: isUploading
                            ? Container(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    backgroundColor: Color(0xff00a368),
                                    radius: 19,
                                    child: Center(
                                      child: Text(
                                        '30%',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: LinearProgressIndicator(),
                                  subtitle: Text(
                                    '$fileName ' ??
                                        'Xerox Hour Nintel Research.pdf',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isUploading = false;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  pickFile();
                                  setState(() {
                                    isLoading = true;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xff00a368),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Upload File ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    isUploading
                        ? Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 15,
                            ),
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
                                SizedBox(height: 10),

                                Text(
                                  'File Info',
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
                                Container(
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
                                    'Publish',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 100,
                                  left: 15,
                                  right: 15,
                                ),
                                child: Center(
                                  child: Text(
                                    'Click the upload file \n button to start \n upload proccess.',
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Color(0xff00a368),
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
                              GestureDetector(
                                onTap: () {
                                  pickFile();
                                  setState(() {
                                    isLoading = true;
                                  });
                                },
                                child: Icon(
                                  Icons.file_upload,
                                  color: Color(0xff00a368).withOpacity(0.25),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
