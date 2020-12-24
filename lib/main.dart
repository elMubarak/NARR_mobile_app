import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:narr/routes/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/login.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDir = await getApplicationDocumentsDirectory();
  var path = appDir.path;

  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await Hive.init(path);

  runApp(
    MyApp(),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Narr',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color(0xff00a368),
          accentColor: Color(0xff00a368),
          cursorColor: Color(0xff00a368),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      initialRoute: Login.id,
      // initialRoute: VerifyAccount.id,
      routes: myRoute,
    );
  }
}
