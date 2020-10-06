import 'dart:convert';

import 'package:http/http.dart' as http;

Future loginUser() async {
  String json = '{"username": "shamskhalil@gmail.com", "password": "secret"}';
  http.Response response = await http.post(
    'http://192.168.1.4:3000/api/v1/auth/login',
    body: jsonDecode(json),
  );

  String data = response.body;
  var token = jsonDecode(data)['payload']['token'];
  var refreshtoken = jsonDecode(data)['payload']['refreshToken'];
  // print(data);
  getRefresToken(refreshtoken);
}

Future getUsers(String token) async {
  http.Response response = await http.get(
    'http://192.168.1.4:3000/api/v1/user',
    headers: {
      "x-token": token,
    },
  );

  String data = response.body;
  // print(data);
  return data;
}

Future getRefresToken(String rToken) async {
  http.Response response = await http.post(
    'http://192.168.1.4:3000/api/v1/refreshToken',
    headers: {
      "refreshtoken": rToken,
    },
  );

  String data = response.body;
  var rtoken = jsonDecode(data)['payload'];
  print(rtoken);
}
