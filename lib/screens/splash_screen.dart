import 'dart:async';

import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
// import 'package:narr/services/backend_service.dart';
import 'package:narr/services/socket_service.dart';
import 'package:narr/store/hive_store.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SocketService _socketService = SocketService();
  String loginUrl = '$serverUrl/auth/login';

  @override
  void initState() {
    // _socketService.connectToServer(context);
    silentLogin();

    super.initState();
  }

  HiveBox _box = HiveBox();

  silentLogin() async {
    String savedToken = await _box.getUser('token');
    if (savedToken != null) {
      _socketService.connectToServer(context);
    } else {
      _socketService.connectToSocketServer();
    }

    Timer(Duration(seconds: 4), () {
      if (savedToken != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, Login.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
