import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:narr/services/socket_service.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/custom_button.dart';

class OcrResult extends StatefulWidget {
  static String id = 'ocrResult';
  final String imagePicked;
  final String selectedFile;
  final Response response;
  final Map headers;
  OcrResult({this.response, this.imagePicked, this.selectedFile, this.headers});

  @override
  _OcrResultState createState() => _OcrResultState();
}

class _OcrResultState extends State<OcrResult> {
  @override
  void initState() {
    super.initState();
    // socketService.createSocketConnection('narr.ng');
    print('result>>> ${widget.response.data}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Result',
                style: TextStyle(
                  color: Color(0xff00a368),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ContainerWithShadow(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 35, bottom: 35, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey[600].withOpacity(0.5),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${widget.response.data}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // CustomBotton(
                    //   isLoading: false,
                    //   buttonTitle: 'Copy Text',
                    //   onTap: () {
                    //     FlutterClipboard.copy(widget.response.data).then(
                    //       (value) => print('Copied'),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
