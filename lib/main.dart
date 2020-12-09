import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:narr/routes/routes.dart';
import 'screens/login.dart';

Injector injector;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
