import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:narr/helpers/permission_helper.dart';

class VideoConferenceScreen extends StatefulWidget {
  static const String id = 'VideoConferenceScreen';
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen> {
  late InAppWebViewController webViewController;
  Uri url = Uri.parse("https://meetings.narr.ng");
  double progress = 0;
  bool isWebLoaded = false;
  Future getPermissions() async {
    PermissionService().requestPermission();
  }

  @override
  void initState() {
    super.initState();
    getPermissions();
    isWebLoaded = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Confrence'),
      ),
      body: Stack(
        children: [
          Container(
            child: InAppWebView(
                // initialUrl: url,
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {
                  setState(() {
                    this.url = url!;
                    print('loaded!');
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {
                  setState(() {
                    this.url = url!;
                    print('Stoped!');
                    isWebLoaded = true;
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
          (isWebLoaded == false)
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(strokeWidth: 7),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
