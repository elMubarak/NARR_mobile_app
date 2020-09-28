import 'package:flutter/material.dart';

class VideoConferenceScreen extends StatefulWidget {
  static const String id = 'VideoConferenceScreen';
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(VideoConferenceScreen.id),
      ),
    );
  }
}
