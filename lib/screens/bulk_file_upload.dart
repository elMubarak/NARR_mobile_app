import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:narr/widgets/custom_button.dart';

class BulkFileUpload extends StatefulWidget {
  static const String id = 'BulkFileUpload';
  @override
  _BulkFileUploadState createState() => _BulkFileUploadState();
}

class _BulkFileUploadState extends State<BulkFileUpload> {
  bool isUpLoading = false;
  bool isFileSelected = false;
  bool isLoading = false;
  List<PlatformFile> myFiles = [];
  File _document;
  PlatformFile _documentInfo;
  PlatformFile _documentInfo2;
  // PlatformFile _documentInfo3;
  // PlatformFile _documentInfo4;
  // PlatformFile _documentInfo5;

  String extensionName;
  String fileName1;
  String fileName2;
  String fileName3;
  String fileName4;
  String fileName5;
  int fileNumbers;
  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf', 'doc', 'txt', 'docx'],
    );

    if (result.files.isNotEmpty) {
      setState(() {
        isFileSelected = true;
        isLoading = false;

        _document = File(result.files.first.path);
        fileNumbers = result.files.length;
        _documentInfo = result.files[0];
        _documentInfo2 = result.files[1];
        // _documentInfo3 = result.files[2];
        // _documentInfo4 = result.files[4];
        // _documentInfo5 = result.files[5];

        extensionName = _documentInfo.extension;
        fileName1 = _documentInfo.name;
        fileName2 = _documentInfo2.name;
        // fileName3 = _documentInfo3.name;
        // fileName4 = _documentInfo4.name;
        // fileName5 = _documentInfo5.name;

        print('the extension ${extensionName ?? extensionName}');
        print('the doc $_document');
        print('file2 is $fileName2 file3 is $fileName3');
      });

      try {
        String fileToUpload = fileName1.split('/').last;
        FormData formData = FormData.fromMap({
          "file": await http.MultipartFile.fromPath(
            fileToUpload,
            _documentInfo.path,
          )
        });
      } catch (e) {
        print(e);
      }
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
          'Bulk Upload',
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
              child: isUpLoading
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: CircleAvatar(),
                            title: LinearProgressIndicator(),
                            subtitle: Text('File Name'),
                            trailing: Text('X'),
                          ),
                          ListTile(
                            leading: CircleAvatar(),
                            title: LinearProgressIndicator(),
                            subtitle: Text('File Name'),
                            trailing: Text('X'),
                          ),
                          ListTile(
                            leading: CircleAvatar(),
                            title: LinearProgressIndicator(),
                            subtitle: Text('File Name'),
                            trailing: Text('X'),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 95,
                          margin: EdgeInsets.only(
                            top: 15,
                            left: 15,
                            right: 15,
                            bottom: 5,
                          ),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: isFileSelected
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )
                                : BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2.5),
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: isFileSelected
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      'Fill The Form With Corresponding Meta-Data',
                                      style: TextStyle(
                                        color: Color(0xff00a368),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: GestureDetector(
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
                                        'Upload Files',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        isFileSelected
                            ? Column(
                                children: [
                                  FileInfoCard(
                                    fileNumber: '1',
                                    fileName: isFileSelected
                                        ? '$fileName1'
                                        : 'SCM-research.pdf',
                                  ),
                                  FileInfoCard(
                                    fileNumber: '2',
                                    fileName: isFileSelected
                                        ? '$fileName2'
                                        : 'SCM-research-part2.pdf',
                                  ),
                                  // FileInfoCard(
                                  //   fileNumber: '3',
                                  //   fileName: isFileSelected
                                  //       ? '$fileName3'
                                  //       : 'the prio justice act.docx',
                                  // ),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 25,
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 20,
                                      top: 20,
                                    ),
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
                                    child: Center(
                                      child: CustomBotton(
                                        buttonTitle: 'Upload',
                                        onTap: () {
                                          if (_document != null) {
                                            setState(() {
                                              isUpLoading = true;
                                            });
                                          } else {
                                            print('No File To Upload');
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                child: Column(
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
                                          'Click the upload files \n button to start \n upload proccess.',
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
                                        color:
                                            Color(0xff00a368).withOpacity(0.25),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
            ),
    );
  }
}

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key key,
    this.fileNumber,
    this.fileName,
  }) : super(key: key);
  final String fileNumber;
  final String fileName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 5,
      ),
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 20,
        top: 10,
      ),
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

          //
          Row(
            children: [
              Text('$fileNumber. '),
              Flexible(
                child: Text(
                  '$fileName',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Topic',
              filled: true,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Author',
              filled: true,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Category',
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
