import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

String baseEndpoint = 'http://192.168.1.4:3000/api/v1';
String logInEndpoint = '/auth/login';
String getAllUsers = '$baseEndpoint/user';
String token = '/token';
String auth = baseEndpoint + logInEndpoint;
String userName = "shamskhalil@gmail.com";
String password = "secret";
String body = '{"username": "$userName", "password": "$password"}';

class NetworkHelper {
  Future loginUser() async {
    print('Test');
    http.Response response = await http.post(
      auth,
      body: jsonDecode(body),
    );

    String data = response.body;

    print(data);
  }

  Future root() async {
    print('Test');
    http.Response response = await http.get(
      baseEndpoint,
    );

    String data = response.body;
    print(data);
  }

  Future getUser() async {
    http.Response response = await http.get(
      getAllUsers,
    );
    String users = response.body;
    print(users);
  }
}
