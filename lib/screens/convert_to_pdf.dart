import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/helpers/file_convert_helper.dart';
import 'package:narr/helpers/file_picker_helper.dart';
import 'package:narr/helpers/permission_helper.dart';
import 'package:narr/widgets/custom_button.dart';

class ConvertToPDF extends StatefulWidget {
  static String id = 'convertToPdf';

  @override
  _ConvertToPDFState createState() => _ConvertToPDFState();
}

class _ConvertToPDFState extends State<ConvertToPDF> {
  String docConvertUrl = '$baseUrl/doc';
  String mylocalUrl = 'http://192.168.43.70:3000/convert';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String filePicked;
  bool isClickable = false;
  String selectedFile;
  Response response;

  FilePickerHelper _filePickerHelper = FilePickerHelper();
  FileConvertHelper _fileConvertHelper = FileConvertHelper();
  PermissionService _permissionService = PermissionService();
  List<String> docConvertionExtensions = [
    'doc',
    'docx',
    'txt',
    'odt',
    'rft',
  ];

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

  @override
  Widget build(BuildContext context) {
    // checkPercent();
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Text(
                  'How To Use',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                          'Select a document with valid extention i.e .doc, .docx, .txt'),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Flexible(
                        child: Text(
                            'Click on the convert botton to convert the document')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                          'Check phone storage and your document will be in the NARR folder'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Image.asset('images/document.png'),
                flag
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '${_filePickerHelper.fileName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => dropFile(),
                            child: Icon(Icons.close),
                          ),
                          SizedBox(width: 10),
                        ],
                      )
                    : Container(),
                SizedBox(height: 20),
                flag
                    ? CustomBotton(
                        isLoading: isClickable,
                        buttonTitle: 'Convert',
                        onTap: () async {
                          setState(() {
                            flag = true;
                          });

                          setState(() {
                            isClickable = true;
                          });

                          // _fileConvertHelper
                          _fileConvertHelper
                              .uploadDocument(
                                filePath: _filePickerHelper.selectedfile,
                                fileName: _filePickerHelper.fileName,
                                context: context,
                                url: docConvertUrl,
                              )
                              .whenComplete(
                                () => setState(
                                  () {
                                    isClickable = false;
                                  },
                                ),
                              );
                          setState(() {});
                          //
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _filePickerHelper.selectDoc(
              allowedExtensions: docConvertionExtensions);
          setState(() {
            flag = true;
          });
        },
        label: Text('Select a file'),
        icon: Icon(Icons.attach_file),
      ),
    );
  }
}
