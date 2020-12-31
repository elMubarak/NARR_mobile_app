import 'dart:convert';
import 'package:narr/provider/app_data.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class User {
  String fullName;
  User({this.fullName});
  User.fromJson(Map<String, dynamic> json) : fullName = json["fullName"];
}

//EVENT:MICROSERVICES
Socket socket;

class SocketService {
  void connectToServer() {
    try {
      // Configure socket transports must be sepecified
      socket = io('wss://api.narr.ng', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (data) {
        print('Connected to socket server');
      });
      socket.on('disconnect', (reason) => print('disconnect $reason'));
      socket.on('error', (err) => print('Error: $err'));
    } catch (e) {
      print(e.toString());
    }
  }

  void handleLoginEvent({String token, dynamic user, context}) {
    try {
      socket.emit(
        'LOGIN',
        {"token": token, "user": user},
      );
      socket.on('EVENT:USER:LOGIN', (data) {
        String fullName = jsonDecode(data)['fullName'];
        String emailSent = user['email'];
        String emailRecieved = jsonDecode(data)['email'];

        if (emailSent == emailRecieved) {
          print('$emailSent is = $emailRecieved');
        } else {
          Provider.of<AppData>(context, listen: false)
              .updatedUserLogInEvent(usersEvent: fullName, context: context);
        }
      });
      socket.on('EVENT:USER:LOGOUT', (data) {
        String fullName = jsonDecode(data)['fullName'];
        Provider.of<AppData>(context, listen: false)
            .updatedUserOutEvent(usersEvent: fullName, context: context);
      });
    } catch (err) {
      print('Error >>> $err');
    }
  }

  void handleSignupEvent(user) {
    try {
      socket.emit(
        'LOGIN',
        {"user": user},
      );
      socket.on('EVENT:USER:LOGIN', (data) {
        print('Event user login $data');
        return data;
      });
    } catch (err) {
      //flush Bar
      print('Error >>> $err');
    }
  }

  void handleUploadService() {
    try {
      socket.on('EVENT:USER:SIGNUP', (data) {
        // print('Event user signup $data');
        return data;
      });
    } catch (e) {
      print('Error ==> $e');
    }
  }
}
