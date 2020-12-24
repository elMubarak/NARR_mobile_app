import 'package:socket_io_client/socket_io_client.dart';

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

  void handleLoginEvent(String token, user) {
    try {
      socket.emit(
        'LOGIN',
        {"token": token, "user": user},
      );
      socket.on('EVENT:USER:LOGIN', (data) {
        print('Event user login $data');
        return data;
      });
    } catch (err) {
      //flush Bar
    }
  }

  void handleLogoutEvent() {
    try {
      socket.on('EVENT:USER:LOGOUT', (data) {
        print('Event user logout $data');
        return data;
      });
    } catch (err) {
      //flush Bar
    }
  }
}
