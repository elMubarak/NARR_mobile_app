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

}
