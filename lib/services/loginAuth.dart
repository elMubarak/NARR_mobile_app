import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );

class NetworkHelper {
  // NetworkHelper(this.url);
  // final String url;

  Future loginUser(String email, String password) async {
    String json = '{"username": "$email", "password": "$password"}';
    http.Response response = await http.post(
      'http://192.168.43.219:3000/api/v1/auth/login',
      body: jsonDecode(json),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return data;
    } else {
      // displayDialog(context, "An Error Occurred",
      //     "No account was found matching that username and password");
    }
  }

  Future registerUser(
      String email, String password, String fname, String lname) async {
    String json =
        '{"username": "$email", "password": "$password", "fname": "$fname", "lname": "$lname"}';
    http.Response response = await http.post(
      'http://192.168.43.219:3000/api/v1/auth/register',
      body: jsonDecode(json),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      return response.statusCode;
    }
  }
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
