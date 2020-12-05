import 'package:web_socket_channel/io.dart';

class SocketService {
  createSocketConnection() async {
    final channel = await IOWebSocketChannel.connect('ws://echo.websocket.org');
    print(channel);
  }
}
