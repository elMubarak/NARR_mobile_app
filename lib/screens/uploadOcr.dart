import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/container_with_shadow.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:narr/services/backend_service.dart';

class UploadOcr extends StatefulWidget {
  final String imagePicked;
  final String selectedFile;
  final Response response;
  final Function onSendProgress;

  UploadOcr(
      {this.imagePicked,
      this.response,
      this.selectedFile,
      this.onSendProgress});

  @override
  _UploadOcrState createState() => _UploadOcrState();
}

class _UploadOcrState extends State<UploadOcr> {
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
      print('progress :: $sent');
      //update the progress
    });
  }

  static String selectedAcceptType = 'text/plain';
  List<String> accetType = [
    'text/plain',
    'text/html',
    'application/xml',
    'application/json',
  ];
  Map<String, dynamic> headers = {
    'Accept': '$selectedAcceptType',
  };

  List<DropdownMenuItem> acceptTypeDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String type in accetType) {
      var newItem = DropdownMenuItem(
        child: Text(type),
        value: type,
      );
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  @override
  Widget build(BuildContext context) {
    bool flag = false;
    return Scaffold(
      body: SafeArea(
        child: ContainerWithShadow(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.selectedFile != null || flag
                  ? ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        value: progress != null ? progress : 0,
                      ),
                      subtitle: Text(
                          progress != null ? '$bytesSent of $bytesTotal' : ''),
                      trailing:
                          Text(progress != null ? '${progress.toInt()} %' : ''),
                    )
                  : Container(),
              Container(
                child: Text(widget.imagePicked),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'Display format',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xff00a368),
                    ),
                  ),
                ),
                hint: Text('Institution Type'),
                value: selectedAcceptType,
                items: acceptTypeDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    selectedAcceptType = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomBotton(
                buttonTitle: 'Convert to Text',
                onTap: () async {
                  flag = true;

                  await NetworkHelper(baseUrl).uploadPhoto(
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
    );
  }
}

class ConvertedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }
}
