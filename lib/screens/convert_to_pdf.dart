import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/helpers/file_convert_helper.dart';
import 'package:narr/helpers/file_picker_helper.dart';
import 'package:narr/helpers/permission_helper.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/custom_button.dart';

class ConvertToPDF extends StatefulWidget {
  static String id = 'convertToPdf';

  @override
  _ConvertToPDFState createState() => _ConvertToPDFState();
}

class _ConvertToPDFState extends State<ConvertToPDF> {
  String docConvertUrl = 'https://doc2pdf.narr.ng/convert/office';
  String mylocalUrl = 'http://192.168.43.70:3000/convert';

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
  double progress;
  int bytesSent;
  int bytesTotal;

  void onSendProgress({int sent, int total}) {
    double percentage = (sent / total * 100);
    setState(() {
      bytesSent = sent;
      bytesTotal = total;
      progress = percentage;
      //update the progress
    });
  }

  void dropFile() {
    _filePickerHelper.fileName = null;
    _filePickerHelper.fileExtension = null;
    _filePickerHelper.selectedfile = null;
    setState(() {
      flag = false;
    });
  }

  @override
  void initState() {
    //
    _permissionService.requestPermission(onPermissionDenied: () {
      _permissionService.requestPermission();
    });
    super.initState();
  }

  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              ? Container(
                                  child: Column(
                                    children: [
                                      Text('${_fileConvertHelper.recieved}'),
                                      Text('${_fileConvertHelper.total}'),
                                    ],
                                  ),
                                )
                              // ListTile(
                              //     contentPadding: EdgeInsets.zero,
                              //     title: LinearProgressIndicator(
                              //       backgroundColor: Colors.grey,
                              //       value: progress != null ? progress : 0,
                              //     ),
                              //     subtitle: Text(progress != null
                              //         ? '$bytesSent of $bytesTotal'
                              //         : ''),
                              //     trailing: Text(progress != null
                              //         ? '${progress.toInt()} %'
                              //         : ''),
                              //   )
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
                              });

                              _fileConvertHelper
                                  .uploadDocument(
                                    filePath: _filePickerHelper.selectedfile,
                                    fileName: _filePickerHelper.fileName,
                                    context: context,
                                    url: docConvertUrl,
                                  )
                                  .whenComplete(
                                    () => setState(() {
                                      isClickable = false;
                                    }),
                                  );
                              //

                              onSendProgress(
                                  sent: _fileConvertHelper.total,
                                  total: _fileConvertHelper.recieved);
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
