import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
// import 'package:narr/services/backend_service.dart';
import 'package:narr/services/socket_service.dart';
import 'package:narr/store/hive_store.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SocketService _socketService = SocketService();
  String loginUrl = '$serverUrl/auth/login';

  @override
  void initState() {
    // _socketService.disconnectFromServer();

    _socketService.connectToSocketServer();
    silentLogin();

    super.initState();
  }

  @override
  void dispose() {
    // _socketService.disconnectFromServer();
    super.dispose();
  }

  HiveBox _box = HiveBox();

  silentLogin() async {
    String savedToken = await _box.getSavedToken();
    var data = await _box.getSavedUser();
    print(data);
    print(savedToken);

    if (savedToken != null) {
      _socketService.connectToEvents(context);

      Timer(Duration(seconds: 4), () {
        currentUser = UserModel.fromJson(data);
        determineDasboard(context);
      });
    } else {
      Navigator.pushReplacementNamed(context, Login.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              SocketService().hnadleLogOutEvent();
              HiveBox().clearToken();
              // socket.destroy();
              Navigator.pushReplacementNamed(context, Login.id);
            },
            child: CircularProgressIndicator()),
      ),
    );
  }
}
