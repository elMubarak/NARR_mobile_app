import 'dart:io';

String indexRequest = 'GET / HTTP/1.1\nConnection: close\n\n';

class SocketIO {
  void socketCon() {
    Socket.connect('google.com', 80).then((sock) {
      print('Connected to => ${sock.remoteAddress}: ${sock.remotePort}');
      sock.listen((data) {
        print(String.fromCharCodes(data).trim());
      }, onDone: () {
        print('done');
      }, onError: (e) {
        print('error:: $e');
        sock.destroy();
      });
      sock.write(indexRequest);
    });
  }
}
