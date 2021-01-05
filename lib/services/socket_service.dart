import 'dart:convert';
import 'package:narr/configs.dart';
import 'package:narr/provider/app_data.dart';
import 'package:narr/store/hive_store.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

//EVENT:MICROSERVICES
Socket socket;
HiveBox _box = HiveBox();

class SocketService {
  void connectToServer() {
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
        String savedToken = await _box.getUser('token');
        dynamic savedUser = await _box.getUser('user');

        // handleLoginEvent(token: savedToken, user: savedUser);
      });
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
      socket.on('EVENT:USER:LOGOUT', (data) {
        String fullName = jsonDecode(data)['fullName'];
        Provider.of<AppData>(context, listen: false)
            .updatedUserOutEvent(usersEvent: fullName, context: context);
      });
    } catch (err) {
      print('Error >>> $err');
    }
  }

  void hnadleLogOutEvent() {
    try {
      socket.emit('LOGOUT');
      socket.close();
      socket.disconnect();
      socket.destroy();
    } catch (e) {
      print(e);
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
