import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/helpers/document_to_pdf.dart';
import 'package:narr/helpers/file_picker.dart';
import 'package:narr/helpers/test.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/container_with_shadow.dart';

String myTesturl = 'https://shamskhalil.ngrok.io/convert/office';

class ConvertToPDF extends StatefulWidget {
  static String id = 'convertToPdf';

  @override
  _ConvertToPDFState createState() => _ConvertToPDFState();
}

class _ConvertToPDFState extends State<ConvertToPDF> {
  FilePickerHelper filePickerHelper = FilePickerHelper();

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
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await filePickerHelper.selectDoc();

              // TestDownload testDownload = TestDownload();
            },
            child: Text('Pick'),
          ),
          GestureDetector(
            onTap: () async {
              // TestDownload testDownload = TestDownload();
              // NetworkHelper networkHelper = NetworkHelper(myTesturl);
              // await networkHelper.uploadFile();
              // await testDownload.getCOnvertedFile();
              TestUpCon testUpCon = TestUpCon();
              await testUpCon.downloadFile(myTesturl,
                  filename: filePickerHelper.selectedfile);
              flag = true;
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
    );
  }
}
