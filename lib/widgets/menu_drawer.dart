import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:narr/screens/admin_dash/admin_dash.dart';
import 'package:narr/screens/chat.dart';
import 'package:narr/screens/convert_to_pdf.dart';
import 'package:narr/screens/crowd_funding.dart';
import 'package:narr/screens/grants.dart';
import 'package:narr/screens/history.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/ictWorks.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/screens/ocr.dart';
import 'package:narr/screens/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narr/screens/repository_list.dart';
import 'package:narr/screens/video_conf.dart';
import 'package:narr/services/socket_service.dart';
import 'package:narr/store/hive_store.dart';
import 'package:narr/widgets/custom_expansion_tile.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15),
            height: 100,
            color: Color(0xff00a368),
            child: Center(
              child: Image.asset(
                'images/narr.png',
                width: 200,
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    enabled: true,
                    onTap: () {
                      // Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                      // Update the state of the app.
                      // ...
                      Navigator.popUntil(
                          context, ModalRoute.withName(HomeScreen.id));
                    },
                  ),
                  //
                  (true)
                      ? ListTile(
                          leading: Icon(Icons.dashboard),
                          title: Text('Dashboard'),
                          enabled: true,
                          onTap: () {
                            // Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                            // Update the state of the app.
                            // ...

                            Navigator.of(context)
                                .popAndPushNamed(AdminDashBoard.id);
                          },
                        )
                      : Container(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.database),
                    title: Text('Repository'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(RepositoryList.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Reading List'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(History.id);
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
                  CustomExpansionTile(
                    title: Text('Grants & Funding'),
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.import_contacts),
                        title: Text('Grants'),
                        onTap: () {
                          // ...
                          Navigator.of(context).popAndPushNamed(Grants.id);
                        },
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.handHoldingUsd),
                        title: Text('Crowd Funding'),
                        onTap: () {
                          // ...
                          Navigator.of(context)
                              .popAndPushNamed(CrowdFunding.id);
                        },
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.laptopCode),
                        title: Text('ICT Works'),
                        onTap: () {
                          // ...
                          Navigator.of(context).popAndPushNamed(IctWorks.id);
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.solidComment),
                    title: Text('Chat'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(ChatScreen.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.textWidth),
                    title: Text('Image to Text'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(OCRScreen.id);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    title: Text('Document Conversion'),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(ConvertToPDF.id);
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
                GestureDetector(
                  onTap: () {
                    SocketService().hnadleLogOutEvent();
                    HiveBox().clearToken();
                    // socket.destroy();
                    Navigator.pushReplacementNamed(context, Login.id);
                  },
                  child: Row(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
