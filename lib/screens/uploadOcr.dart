import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class UploadOcr extends StatefulWidget {
  final File pickedCameraImage;
  final String imagePicked;
  final String selectedFile;
  final Response response;
  final Function onSendProgress;

  UploadOcr(
      {this.imagePicked,
      this.response,
      this.selectedFile,
      this.onSendProgress,
      this.pickedCameraImage});

  @override
  _UploadOcrState createState() => _UploadOcrState();
}

class _UploadOcrState extends State<UploadOcr> {
  bool flag = false;
  bool isClickable = false;
  String imageToText = '$baseUrl/ocr';

  double progress;
  int bytesSent;
  int bytesTotal;
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'convert OCR',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: ContainerWithShadow(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                Text('Select Convertion method'),
                SizedBox(
                  height: 15,
                ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
