import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/helpers/file_picker.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class ConvertToPDF extends StatefulWidget {
  static String id = 'convertToPdf';

  @override
  _ConvertToPDFState createState() => _ConvertToPDFState();
}

class _ConvertToPDFState extends State<ConvertToPDF> {
  String filePicked;
  String selectedFile;
  Response response;
  FilePickerHelper filePicker = FilePickerHelper();
  List<String> convertionExtensions = [
    'doc',
    'docx',
    'txt',
    'odt',
    'rft',
  ];
  double progress;
  int bytesSent;
  int bytesTotal;

  void onSendProgress(int sent, int total) {
    double percentage = (sent / total * 100);
    setState(() {
      bytesSent = sent;
      bytesTotal = total;
      progress = percentage;
      //update the progress
    });
  }

  void dropFile() {
    filePicker.fileName = null;
    filePicker.fileExtension = null;
    filePicker.selectedfile = null;
    setState(() {
      flag = false;
    });
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
                                '${filePicker.fileName}',
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
                          GestureDetector(
                            onTap: () async {
                              flag = true;

                              // await NetworkHelper(
                              //         url:
                              //             'http://shamskhalil.ngrok.io/convert/office')
                              //     .uploadFile(
                              //         response: response,
                              //         selectedfile: filePicker.selectedfile,
                              //         onSendProgress: onSendProgress,
                              //         trancitionedScreen: ConvertToPDF(),
                              //         context: context);

                              await NetworkHelper(
                                      url: 'http://192.168.43.219:3000/convert')
                                  .uploadFile(
                                      response: response,
                                      selectedfile: filePicker.selectedfile,
                                      onSendProgress: onSendProgress,
                                      trancitionedScreen: ConvertToPDF(),
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
                                'Convert',
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
              ),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await filePicker.selectDoc(
                          allowedExtensions: convertionExtensions);
                      setState(() {
                        flag = true;
                      });
                    },
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
                ],
              ),
            ),
    );
  }
}
