import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/provider/app_data.dart';
import 'package:narr/store/hive_store.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

//EVENT:MICROSERVICES
Socket socket;
HiveBox _box = HiveBox();

class SocketService {
  void connectToSocketServer() {
    try {
      // Configure socket transports must be sepecified
      socket = io(socketServerUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (data) {
        print('Connected to socket server');
      });
    } catch (e) {
      print("Error connecting to socket server $e");
    }
  }

  void connectToServer(BuildContext context) async {
    String savedToken = await _box.getUser('token');
    dynamic savedUser = await _box.getUser('user');
    try {
      // Configure socket transports must be sepecified
      socket = io(socketServerUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (data) {
        print('Connected to socket server');
      });
      socket.on('disconnect', (reason) async {
        print('disconnect $reason');
        // handleLoginEvent(token: savedToken, user: savedUser);
      });
      if (savedToken != null) {
        handleLoginEvent(token: savedToken, user: savedUser, context: context);
      } else {}

      // socket.on('reconnect', (reason) {
      //   print('disconnect $reason');

      //   handleLoginEvent(token: savedToken, user: savedUser, context: context);
      // });
      socket.on('error', (err) => print('Error: $err'));
    } catch (e) {
      print(e.toString());
    }
  }

  void handleLoginEvent({String token, dynamic user, context}) async {
    dynamic savedUser = await _box.getUser('user');
    try {
      socket.emit(
        'LOGIN',
        {"token": token, "user": user},
      );
      socket.on('EVENT:USER:LOGIN', (data) {
        String fullName = jsonDecode(data)['fullName'];
        String emailSent = user['email'];
        String emailRecieved = jsonDecode(data)['email'];
        var onlineUsers =
            Provider.of<AppData>(context, listen: false).usersOnlineList;
        // for (var i = 0; i < onlineUsers.length; i++) {
        //   var obj = onlineUsers[i];
        // if (onlineUsers.contains(jsonDecode(data)) == true) {
        //   print('Already Exist');
        // } else {
        onlineUsers.add(jsonDecode(data));
        // onlineUsers.toSet().toList();
        // }
        // }

        String message;
        if (emailSent == emailRecieved) {
          message = "Welcome";
          print('$emailSent is = $emailRecieved');
          Provider.of<AppData>(context, listen: false).updatedUserLogInEvent(
              user: fullName, context: context, msg: message);
        } else {
          message = "is Online";
          Provider.of<AppData>(context, listen: false).updatedUserLogInEvent(
              user: fullName, context: context, msg: message);
        }
      });
      socket.on('EVENT:USERS:CURRENTLY:ONLINE', (data) {
        final users = jsonDecode(data);
        Provider.of<AppData>(context, listen: false)
            .updatedUsersOnline(usersOnline: users);
      });

      socket.on('EVENT:USER:LOGOUT', (data) {
        String fullName = jsonDecode(data)['fullName'];
        String logoutEmail = jsonDecode(data)['email'];
        Provider.of<AppData>(context, listen: false)
            .updatedUserOutEvent(usersEvent: fullName, context: context);
        var onlineUsers =
            Provider.of<AppData>(context, listen: false).usersOnlineList;
        for (var i = 0; i < onlineUsers.length; i++) {
          var obj = onlineUsers[i];
          if (obj['email'] == logoutEmail) {
            onlineUsers.removeAt(i);
          }
        }
      });
    } catch (err) {
      print('Error >>> $err');
    }
  }

  void hnadleLogOutEvent() {
    try {
      socket.emit('LOGOUT');
    } catch (e) {
      print('log out error ::==> $e');
    }
  }

  void handleSignupEvent(user) {
    try {
      socket.on('EVENT:USER:SIGNUP', (data) {
        print('Event  $data');
        return data;
      });
    } catch (err) {
      //flush Bar
      print('Error >>> $err');
    }
  }

  void handleUploadService() {
    try {
      socket.on('EVENT:RESEARCH:NEW', (data) {
        print('Research upload event $data');
        return data;
      });
    } catch (e) {
      print('Error ==> $e');
    }
  }
}
