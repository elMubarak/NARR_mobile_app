import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/container_with_shadow.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:narr/services/backend_service.dart';

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
  String baseUrl = 'https://shamskhalil.ngrok.io/tika/form';

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

  // static String selectedAcceptType = 'text/plain';
  // List<String> acceptType = [
  //   'text/plain',
  //   'text/html',
  //   // 'application/xml',
  // ];
  List<String> dropDownValue = [
    //
    'text',
    'html',
    'xml',
    'json'
  ];
  Map<String, dynamic> headers = {
    'Accept': 'text/plain',
  };

  // List<DropdownMenuItem> acceptTypeDropdownItems() {
  //   List<DropdownMenuItem<String>> dropdowmItems = [];

  //   for (String type in acceptType) {
  //     var newItem = DropdownMenuItem(
  //       child: Text(type),
  //       value: type,
  //     );
  //     dropdowmItems.add(newItem);
  //   }
  //   return dropdowmItems;
  // }

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
                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: false,
                        //   builder: (context) {
                        //     return Container(
                        //       color: Colors.white,
                        //       child: Column(
                        //         children: [
                        //           Text('Are you Sure you wan\'t to close?')
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );
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
                // Container(
                //   child: Text(widget.imagePicked),
                // ),
                Text('Select Convertion method'),
                SizedBox(
                  height: 15,
                ),
                // DropdownButtonFormField(
                //   decoration: InputDecoration(
                //     hintText: 'Display format',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //       borderSide: BorderSide(
                //         color: Color(0xff00a368),
                //       ),
                //     ),
                //   ),
                //   hint: Text('convert Type'),
                //   value: selectedAcceptType,
                //   items: acceptTypeDropdownItems(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedAcceptType = value;
                //       print(selectedAcceptType);
                //     });
                //   },
                // ),
                SizedBox(
                  height: 25,
                ),
                CustomBotton(
                  buttonTitle: 'Convert',
                  onTap: () async {
                    widget.imagePicked != null
                        ? setState(() {
                            flag = true;
                          })
                        : setState(() {
                            flag = false;
                          });

                    await NetworkHelper(url: baseUrl).uploadPhoto(
                      response: widget.response,
                      selectedfile: widget.selectedFile,
                      onSendProgress: onSendProgress,
                      headers: headers,
                      context: context,
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
