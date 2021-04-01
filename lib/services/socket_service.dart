import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/store/hive_store.dart';
import 'package:narr/widgets/flush_snackbar.dart';
import 'package:socket_io_client/socket_io_client.dart';

//EVENT:MICROSERVICES
Socket socket;
HiveBox _box = HiveBox();
List usersOnlineArray = [];

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
        print('Connected to socket server ');
      });
    } catch (e) {
      print("Error connecting to socket server $e");
    }
  }

  void connectToEvents(BuildContext context) async {
    //getting token and user object from local storage
    String savedToken = await _box.getUser('token');
    dynamic savedUser = await _box.getUser('user');
    try {
      //checking if the token is not null
      if (savedToken != null) {
        //running the handle login even function
        handleLoginEvent(token: savedToken, user: savedUser, context: context);
      } else {
        print('null token re route to login');
      }

      //when the socket tries to reconnect
      socket.on('reconnect', (reason) {
        print('disconnect $reason');
        //running the handle login even function
        handleLoginEvent(token: savedToken, user: savedUser);
      });
      socket.on('error', (err) => print('Error: $err'));
    } catch (e) {
      print(e.toString());
    }
  }

  //handle login event function
  void handleLoginEvent(
      {String token, dynamic user, BuildContext context}) async {
    dynamic savedUser = await _box.getUser('user');

    try {
      //Emitting the login event with token and user object
      socket.emit(
        'LOGIN',
        {"token": token, "user": user},
      );

      //listening for an event called EVENT:USERS:CURRENTLY:ONLINE;
      socket.on('EVENT:USERS:CURRENTLY:ONLINE', (data) {
        //decodeing the response gotten from the server
        final decodedData = jsonDecode(data);

        //saving the response to mobX
        usersOnlineArray = decodedData['usersOnline'];
        readingHistory.getReadingHistory(decodedData['readingHistory']);

        //listening for an event called EVENT:USER:LOGIN
        socket.on('EVENT:USER:LOGIN', (data) {
          var res = jsonDecode(data);
          String fullName = res['fullName'];
          String emailSent = savedUser['email'];
          String emailRecieved = res['email'];

          usersOnlineArray.add(jsonDecode(data));
          final jsonList =
              usersOnlineArray.map((item) => jsonEncode(item)).toList();

          // using toSet - toList strategy
          final uniqueJsonList = jsonList.toSet().toList();

          // convert each item back to the original form using JSON decoding
          final result =
              uniqueJsonList.map((item) => jsonDecode(item)).toList();

          onlineUsers.getNumberOfUsersOnline(result);
          print(onlineUsers.numberOfUsersOnline.length);

          String message;
          if (emailSent == emailRecieved) {
            message = "Welcome";

            // print('$emailSent is = $emailRecieved');
            showLoginFlushbar(
                message: message, user: fullName, context: context);
          } else {
            message = "is Online";
            showLoginFlushbar(
                message: message, user: fullName, context: context);
          }
        });

        // tempArray = users;
      });

      socket.on('EVENT:USER:LOGOUT', (data) {
        // String fullName = jsonDecode(data)['fullName'];
        String logoutEmail = jsonDecode(data)['email'];

        for (var i = 0; i < usersOnlineArray.length; i++) {
          var obj = usersOnlineArray[i];
          if (obj['email'] == logoutEmail) {
            usersOnlineArray.removeAt(i);
            print("${obj['email']} and $logoutEmail");
            onlineUsers.getNumberOfUsersOnline(usersOnlineArray);
            print(onlineUsers.numberOfUsersOnline.length);
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
