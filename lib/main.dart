import 'package:flutter/material.dart';
import 'package:narr/screens/about.dart';
import 'package:narr/screens/bulk_file_upload.dart';
import 'package:narr/screens/chat.dart';
import 'package:narr/screens/document_convert.dart';
import 'package:narr/screens/forgotPassword.dart';
import 'package:narr/screens/history.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/screens/ocr.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/screens/register.dart';
import 'package:narr/screens/single_file_upload.dart';
import 'package:narr/screens/upload_document.dart';
import 'package:narr/screens/video_conf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff00a368),
        // splashColor: Color(0xff00a368),
        accentColor: Color(0xff00a368),
        cursorColor: Color(0xff00a368),

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Login.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        UploadDoc.id: (context) => UploadDoc(),
        SingleFileUpload.id: (context) => SingleFileUpload(),
        BulkFileUpload.id: (context) => BulkFileUpload(),
        ChatScreen.id: (context) => ChatScreen(),
        OCRScreen.id: (context) => OCRScreen(),
        AboutUs.id: (context) => AboutUs(),
        VideoConferenceScreen.id: (context) => VideoConferenceScreen(),
        DocumentConvert.id: (context) => DocumentConvert(),
        Profile.id: (context) => Profile(),
        History.id: (context) => History(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        ForgotPassword.id: (context) => ForgotPassword(),
      },
    );
  }
}
