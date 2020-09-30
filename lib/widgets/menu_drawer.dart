import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:narr/screens/about.dart';
import 'package:narr/screens/chat.dart';
import 'package:narr/screens/document_convert.dart';
import 'package:narr/screens/history.dart';
import 'package:narr/screens/ocr.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/screens/research_grants.dart';
import 'package:narr/screens/video_conf.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            color: Color(0xff00a368),
            child: Center(
              child: Text(
                'NARR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.chrome_reader_mode),
                    title: Text('Document Convertion'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(DocumentConvert.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Reading History'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(History.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text('Research Grant'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(ResearchGrants.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.show_chart),
                    title: Text('Analytics'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(ChatScreen.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(Profile.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Chat'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(ChatScreen.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings_overscan),
                    title: Text('OCR'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(OCRScreen.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.video_call),
                    title: Text('Video Conferencing'),
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(VideoConferenceScreen.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(AboutUs.id);
                      // ...
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.red.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Icon(Icons.exit_to_app),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
