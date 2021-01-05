import 'dart:async';

import 'package:flutter/material.dart';
import 'package:narr/provider/app_data.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    silentLogin();

    super.initState();
  }

  silentLogin() {
    Timer(Duration(seconds: 5), () {
      if (Provider.of<AppData>(context, listen: false).userToken != null) {
        Navigator.of(context).pushNamed(HomeScreen.id);
      } else {
        Navigator.of(context).pushNamed(Login.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppData>(context).getUserToken();

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
