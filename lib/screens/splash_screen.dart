import 'dart:async';

import 'package:flutter/material.dart';
import 'package:narr/provider/app_data.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/services/socket_service.dart';
import 'package:narr/store/hive_store.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SocketService _socketService = SocketService();
  @override
  void initState() {
    silentLogin();

    super.initState();
  }

  HiveBox _box = HiveBox();

  silentLogin() {
    Timer(Duration(seconds: 5), () async {
      if (Provider.of<AppData>(context, listen: false).userToken != null) {
        dynamic savedUser = await _box.getUserAndToken('user');
        String savedToken = await _box.getUserAndToken('token');

        _socketService.connectToServer();
        _socketService.handleLoginEvent(
            user: savedUser, token: savedToken, context: context);
        // print(Provider.of<AppData>(context, listen: false).userObject);
        Navigator.of(context).pushReplacementNamed(HomeScreen.id);
      } else {
        Navigator.of(context).pushReplacementNamed(Login.id);
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
