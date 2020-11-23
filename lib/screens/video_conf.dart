import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:narr/helpers/permission_helper.dart';

class VideoConferenceScreen extends StatefulWidget {
  static const String id = 'VideoConferenceScreen';
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen> {
  InAppWebViewController _webViewController;
  String url = "https://meetings.lvs.ng";
  double progress = 0;

  Future getPermissions() async {
    PermissionService().requestPermission(onPermissionDenied: () {
      print('Permission has been denied');
    });
  }

  @override
  void initState() {
    super.initState();
    getPermissions();
    if (Platform.isAndroid) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: InAppWebView(
            initialUrl: url,
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(debuggingEnabled: true),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
            },
            onLoadStart: (InAppWebViewController controller, String url) {
              setState(() {
                this.url = url;
              });
            },
            onLoadStop: (InAppWebViewController controller, String url) async {
              setState(() {
                this.url = url;
              });
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
            androidOnPermissionRequest: (InAppWebViewController controller,
                String origin, List<String> resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            }),
      ),
    );
  }
}
