import 'dart:async';

import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/provider/app_data.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/services/backend_service.dart';
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
  String loginUrl = '$serverUrl/auth/login';

  @override
  void initState() {
    _socketService.connectToServer();
    silentLogin();

    super.initState();
  }

  HiveBox _box = HiveBox();

  silentLogin() {
    Timer(Duration(seconds: 3), () async {
      String savedToken = await _box.getUser('token');
      String savedPassword = await _box.getUser('password');
      String savedEmail = await _box.getUser('email');
      print('token here $savedToken');

      if (savedToken != null) {
        NetworkHelper(url: loginUrl)
            .loginUser(
                email: savedEmail, password: savedPassword, context: context)
            .whenComplete(() => setState(() {
                  Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                }));
        // print(Provider.of<AppData>(context, listen: false).userObject);
      } else {
        Navigator.of(context).pushReplacementNamed(Login.id);
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
