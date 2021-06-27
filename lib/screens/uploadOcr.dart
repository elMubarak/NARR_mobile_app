import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/custom_button.dart';

class UploadOcr extends StatefulWidget {
  final File pickedCameraImage;
  final String imagePicked;
  final String selectedFile;
  final Response response;
  final VoidCallback onSendProgress;

  UploadOcr(
      {required this.imagePicked,
      required this.response,
      required this.selectedFile,
      required this.onSendProgress,
      required this.pickedCameraImage});

  @override
  _UploadOcrState createState() => _UploadOcrState();
}

class _UploadOcrState extends State<UploadOcr> {
  bool flag = false;
  bool isClickable = false;
  Uri imageToText = Uri.parse('$baseUrl/ocr');

  double progress = 0;
  int bytesSent = 0;
  int bytesTotal = 0;
  void onSendProgress(int sent, int total) {
    double percentage = (sent / total * 100);
    setState(() {
      bytesSent = sent;
      bytesTotal = total;
      progress = percentage;
      print('progress: $sent');
      //update the progress
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                          'Select image from file or snap the image you wish to get the text from'),
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
                            'Click on the convert botton to extract the text from the image')),
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
                      child:
                          Text('Your text will be extracted and can be copied'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.all(15),
                      height: 300,
                      width: double.infinity,
                      child: widget.imagePicked != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                widget.pickedCameraImage,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff00a368),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // widget.imagePicked != null
                flag
                    ? ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: LinearProgressIndicator(
                          backgroundColor: Colors.grey,
                          value: progress != null ? progress : 0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff00a368),
                          ),
                        ),
                        subtitle: Text(progress != null
                            ? '$bytesSent of $bytesTotal'
                            : ''),
                        trailing: Text(
                            progress != null ? '${progress.toInt()} %' : ''),
                      )
                    : Container(),
                SizedBox(
                  height: 25,
                ),
                CustomBotton(
                  isLoading: isClickable,
                  buttonTitle: 'Convert',
                  onTap: () async {
                    widget.imagePicked != null
                        ? setState(() {
                            flag = true;
                          })
                        : setState(() {
                            flag = false;
                          });
                    setState(() {
                      isClickable = true;
                    });

                    await NetworkHelper(url: imageToText)
                        .uploadPhoto(
                          response: widget.response,
                          selectedfile: widget.selectedFile,
                          onSendProgress: onSendProgress,
                          context: context,
                        )
                        .whenComplete(
                          () => setState(() {
                            isClickable = false;
                          }),
                        );
                  },
                  buttonColor: determinePrimaryColor(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
