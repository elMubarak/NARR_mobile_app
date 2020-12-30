import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:narr/provider/app_data.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/widgets/flush_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

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

  handleLoginEvent({String token, user, context}) {
    try {
      socket.emit(
        'LOGIN',
        {"token": token, "user": user},
      );
      socket.on('EVENT:USER:LOGIN', (data) {
        // print('Event user login $data');
        String loggedInUser = data['fullName'];
        Provider.of<AppData>(context, listen: false)
            .updatedUserLogInEvent(usersEvent: loggedInUser, context: context);
      });
    } catch (err) {
      //flush Bar
      print('Error >>> $err');
    }
    // print('GDATA is r=> $gData');
  }

  void handleLogoutEvent() {
    try {
      socket.on('EVENT:USER:LOGOUT', (data) {
        print('Event user logout $data');
        return data;
      });
    } catch (err) {
      //flush Bar
      print('Error >>> $err');
    }
  }

  void _showToast(BuildContext context) {
    print('toasty');
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Updating..'),
      ),
    );

    this._showToast(context);
  }

  void handleSignupEvent(context) {
    dynamic gData;
    try {
      socket.on('EVENT:USER:SIGNUP', (data) {
        // print('Event user signup $data');
        gData = data;
        return data;
      });
    } catch (err) {
      //flush Bar
      print('Error >>> $err');
    }
    print('Event user signup==> $gData');
    return gData;
  }

  void handleUploadService() {
    try {} catch (e) {
      print('Error ==> $e');
    }
  }
}
