import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/helpers/file_convert_helper.dart';
import 'package:narr/helpers/file_picker_helper.dart';

class ConvertToPDF extends StatefulWidget {
  static String id = 'convertToPdf';

  @override
  _ConvertToPDFState createState() => _ConvertToPDFState();
}

class _ConvertToPDFState extends State<ConvertToPDF> {
  String myTesturl = 'https://shamskhalil.ngrok.io/convert/office';
  String mylocalUrl = 'http://192.168.43.70:3000/convert';

  String filePicked;
  String selectedFile;
  Response response;
  FilePickerHelper _filePickerHelper = FilePickerHelper();
  FileConvertHelper _fileConvertHelper = FileConvertHelper();
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
    _filePickerHelper.fileName = null;
    _filePickerHelper.fileExtension = null;
    _filePickerHelper.selectedfile = null;
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
              await _filePickerHelper.selectDoc();
            },
            child: Text('Pick'),
          ),
          GestureDetector(
            onTap: () async {
              _fileConvertHelper.uploadDocument(
                  filePath: _filePickerHelper.selectedfile,
                  fileName: _filePickerHelper.fileName,
                  url: mylocalUrl);
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
