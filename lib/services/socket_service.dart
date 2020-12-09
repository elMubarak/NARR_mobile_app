import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

String indexRequest = 'GET / HTTP/1.1\nConnection: close\n\n';

String serverUrl = 'wss://javascript.info/article/websocket/demo/hello';

class SocketConnection {
  void socketCon(String message) {
    var channel = IOWebSocketChannel.connect(serverUrl);
    channel.sink.add(message);
    channel.stream.listen((message) {
      //
      print(message);
    });
  }

  void socketAuth() {
    IO.Socket socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.onConnect((data) {
      print('connected');
      // socket.emit('LOGIN', {token, userObj});
    });

    socket.onConnecting((data) => print('connecting'));
    socket.onConnectError((err) => print("Errror >>> $err"));
    // socket.on('event', (data) => print(data));
    socket.onDisconnect((data) => print('disconnected $data'));
  }
}

class SocketService {
  IO.Socket socket;

  createSocketConnection() {
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
    });

    this.socket.onConnect((data) => print('Connected'));
    this.socket.onReconnect((data) => print('Reconnecting'));
    this.socket.onConnectError((data) => print('Error >> $data'));
    this.socket.on("disconnect", (_) => print('Disconnected'));
  }
}
