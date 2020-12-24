import 'package:socket_io_client/socket_io_client.dart';

Socket socket;

class SocketService {
  void connectToServer(token, user) {
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
        socket.emit('LOGIN', {token, user});
        socket.on('EVENT:USER:LOGIN', (data) => print('Event user login '));
      });
      socket.on('disconnect', (reason) => print('disconnect $reason'));
      socket.on('error', (err) => print('Error: $err'));
    } catch (e) {
      print(e.toString());
    }
  }
}
