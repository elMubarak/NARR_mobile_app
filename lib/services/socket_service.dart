<<<<<<< HEAD
import 'package:web_socket_channel/io.dart';

class SocketService {
  createSocketConnection() async {
    final channel = await IOWebSocketChannel.connect('ws://echo.websocket.org');
    print(channel);
  }
=======
import 'package:socket_io_client/socket_io_client.dart' as socketio;
import 'package:socket_io_client/socket_io_client.dart';

String indexRequest = 'GET / HTTP/1.1\nConnection: close\n\n';

class SocketConnection {
  // void socketCon() {
  //   Socket.connect('https://api.narr.ng', 3000).then((sock) {
  //     print('Connected to => ${sock.remoteAddress}: ${sock.remotePort}');
  //     sock.listen((data) {
  //       print(String.fromCharCodes(data).trim());
  //     }, onDone: () {
  //       print('done');
  //     }, onError: (e) {
  //       print('error:: $e');
  //       sock.destroy();
  //     });
  //     sock.write(indexRequest);
  //   });
  // }

>>>>>>> 1c0cb58ae091f52c600c864fb692a6cd6fdbac2e
}
