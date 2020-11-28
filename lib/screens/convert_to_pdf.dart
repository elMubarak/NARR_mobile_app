import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:narr/helpers/file_convert_helper.dart';
import 'package:narr/helpers/file_picker_helper.dart';
import 'package:narr/helpers/permission_helper.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class ConvertToPDF extends StatefulWidget {
  static String id = 'convertToPdf';

  @override
  _ConvertToPDFState createState() => _ConvertToPDFState();
}

class _ConvertToPDFState extends State<ConvertToPDF> {
  String docConvertUrl = 'https://doc2pdf.narr.ng/convert/office';
  String mylocalUrl = 'http://192.168.43.70:3000/convert';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String filePicked;
  bool isClickable = false;
  String selectedFile;
  Response response;

  FilePickerHelper _filePickerHelper = FilePickerHelper();
  // FileConvertHelper _fileConvertHelper = FileConvertHelper();
  PermissionService _permissionService = PermissionService();
  List<String> docConvertionExtensions = [
    'doc',
    'docx',
    'txt',
    'odt',
    'rft',
  ];

  // progress() {
  //   bytesRecieved = recieved;
  //   bytesTotal = total;
  //   percent = (bytesRecieved / bytesTotal * 100);
  // }

  void dropFile() {
    setState(() {
      _filePickerHelper.fileName = null;
      _filePickerHelper.fileExtension = null;
      _filePickerHelper.selectedfile = null;
    });

    setState(() {
      flag = false;
    });
  }

  @override
  void initState() {
    _permissionService.requestPermission(onPermissionDenied: () {
      _permissionService.requestPermission();
    });
    super.initState();
  }

  bool flag = false;

  File pickedFile;
  List<int> bytes = [];
  int recieved = 0;
  int total = 0;
  double percent;

  Future uploadDocument(
      {String filePath,
      String fileName,
      String url,
      BuildContext context}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
        await http.MultipartFile.fromPath('file', filePath),
      );
      var res = await request.send();
      //works at once
      setState(() {
        total = res.contentLength;
      });
      print('start size before write $recieved');
      if (res.contentLength == 0) {
        return res.contentLength;
      }

      String getDir = await ExtStorage.getExternalStorageDirectory();
      String folderToSaveConver = 'Narr/Converted';
      String fileToSave = fileName;
      Directory fullFolderDirToSave = Directory('$getDir/$folderToSaveConver');

      if (await fullFolderDirToSave.exists()) {
        res.stream.listen(
          (value) async {
            bytes.addAll(value);
            setState(() {
              recieved += value.length;
            });
            bytes.clear();
            recieved = 0;
          },
        ).onDone(() async {
          final fileToWrite = File(
            '${fullFolderDirToSave.path}/${fileToSave.split('.')[0]}.pdf',
          );
          await fileToWrite.writeAsBytes(bytes);
          print('start size after write  $recieved');
          print('total size $total');
          pickedFile = fileToWrite;
          if (recieved == total) {
            print('ok');
            setState(() {
              percent = (recieved / total * 100);
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('File Converted got to Narr folder'),
                duration: Duration(seconds: 3),
              ));
            });
            bytes.clear();

            // Navigator.pop(context);
            dropFile();
          } else if (recieved < total) {
            print('less bytes');
            dropFile();
          } else {
            print('too much');
            dropFile();
          }
        });

        displayDialog(
            context, "Success", "$fileName file converted successfully");
        print('file path => ${pickedFile.path}');
        print(
            'status code ::==> ${res.statusCode} and reason phrase ::==> ${res.reasonPhrase}');
      } else {
        await fullFolderDirToSave.create(recursive: true);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // checkPercent();
    return Scaffold(
      key: _scaffoldKey,
      body: flag
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerWithShadow(
                      child: Column(
                        children: [
                          flag
                              ? ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: LinearProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    value: percent != null ? percent : 0,
                                  ),
                                  subtitle: Text(percent != null
                                      ? '$recieved of $total'
                                      : ''),
                                  trailing: Text(percent != null
                                      ? '${percent.toInt()} %'
                                      : ''),
                                )
                              : Container(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${_filePickerHelper.fileName}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              InkWell(
                                onTap: () => dropFile(),
                                child: Icon(Icons.close),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: 20),
                          CustomBotton(
                            isLoading: isClickable,
                            buttonTitle: 'Convert',
                            onTap: () async {
                              setState(() {
                                flag = true;
                              });

                              setState(() {
                                isClickable = true;

                                print(
                                    'ui recieved $recieved and ui total $total');
                              });

                              // _fileConvertHelper
                              uploadDocument(
                                filePath: _filePickerHelper.selectedfile,
                                fileName: _filePickerHelper.fileName,
                                context: context,
                                url: docConvertUrl,
                              ).whenComplete(
                                () => setState(
                                  () {
                                    isClickable = false;
                                  },
                                ),
                              );
                              setState(() {});
                              //
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // await _filePickerHelper.selectDoc(
                      //     allowedExtensions: convertionExtensions);
                      await _filePickerHelper.selectDoc(
                          allowedExtensions: docConvertionExtensions);
                      setState(() {
                        flag = true;
                      });
                    },
                    child: Center(
                      child: ContainerWithShadow(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Center(
                                child: Text(
                                  'Select File to be converted',
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
                  ),
                ],
              ),
            ),
    );
  }
}
