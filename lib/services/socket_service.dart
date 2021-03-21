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
  List readingHistory;
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
        print('Connected to socket server ');
      });
    } catch (e) {
      print("Error connecting to socket server $e");
    }
  }

  void connectToEvents(BuildContext context) async {
    String savedToken = await _box.getUser('token');
    dynamic savedUser = await _box.getUser('user');
    try {
      if (savedToken != null) {
        handleLoginEvent(token: savedToken, user: savedUser, context: context);
      } else {
        print('null token re route to login');
      }

      socket.on('reconnect', (reason) {
        print('disconnect $reason');

        handleLoginEvent(token: savedToken, user: savedUser, context: context);
      });
      socket.on('error', (err) => print('Error: $err'));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> handleLoginEvent({String token, dynamic user, context}) async {
    try {
      socket.emit(
        'LOGIN',
        {"token": token, "user": user},
      );
      socket.on('EVENT:USER:LOGIN', (data) {
        String fullName = jsonDecode(data)['fullName'];
        String emailSent = user['email'];
        String emailRecieved = jsonDecode(data)['email'];
        // tempArray.add(jsonDecode(data));
        // var onlineUsers = tempArray;
        // final jsonList = onlineUsers.map((item) => jsonEncode(item)).toList();

        // // using toSet - toList strategy
        // final uniqueJsonList = jsonList.toSet().toList();

        // // convert each item back to the original form using JSON decoding
        // final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
        // Provider.of<AppData>(context, listen: false)
        //     .updatedUsersOnline(usersOnline: result);

        var onlineUsers = Provider.of<AppData>(context, listen: false)
            .analyticObj['usersOnline'];

        onlineUsers.add(jsonDecode(data));
        print(onlineUsers);

        String message;
        if (emailSent == emailRecieved) {
          message = "Welcome";
          // print('$emailSent is = $emailRecieved');
          Provider.of<AppData>(context, listen: false).updatedUserLogInEvent(
              user: fullName, context: context, msg: message);
        } else {
          message = "is Online";
          Provider.of<AppData>(context, listen: false).updatedUserLogInEvent(
              user: fullName, context: context, msg: message);
        }
      });
      socket.on('EVENT:USERS:CURRENTLY:ONLINE', (data) {
        final decodedData = jsonDecode(data);
        // Provider.of<AppData>(context, listen: false)
        //     .updatedUsersOnline(model: decodedData);
        Provider.of<AppData>(context, listen: false)
            .getAnalyticsStream(analytics: decodedData);

        // tempArray = users;
      });

      socket.on('EVENT:USER:LOGOUT', (data) {
        String fullName = jsonDecode(data)['fullName'];
        String logoutEmail = jsonDecode(data)['email'];
        Provider.of<AppData>(context, listen: false)
            .updatedUserOutEvent(usersEvent: fullName, context: context);
        var onlineUsers = Provider.of<AppData>(context, listen: false)
            .analyticObj['usersOnline'];
        for (var i = 0; i < onlineUsers.length; i++) {
          var obj = onlineUsers[i];
          if (obj['email'] == logoutEmail) {
            onlineUsers.removeAt(i);
            // print("${obj['email']} and $logoutEmail");
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

  void disconnectFromServer() {
    socket.close();
  }
}
