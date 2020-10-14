import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/verify_email.dart';

//registration
Future<UserRegistrationModel> userRegistration(
  String username,
  String password,
  String fname,
  String lname,
  String dob,
  String phone,
  String address,
  String institutionType,
  String institutionName,
  BuildContext context,
) async {
  final http.Response response = await http.post(
    'http://192.168.43.219:3000/api/v1/auth/register',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, dynamic>{
        "username": username,
        "password": password,
        "fname": fname,
        "lname": lname,
        "dob": dob,
        "phone": phone,
        "address": address,
        "institution": {
          "name": institutionName,
          "type": institutionType,
        },
      },
    ),
  );

  if (response.statusCode == 200) {
    String data = response.body;
    print(data);

    Navigator.pushNamed(context, VerifyAccount.id);

    // var fullName = jsonDecode(data)['payload']['fullName'];
    // var username = jsonDecode(data)['paylaod']['username'];
    // return fullName;
  } else {
    throw Exception('${response.statusCode} Failed to create a user.');
  }
}

//login
Future<UserLoginModel> loginUser(String username, String password) async {
  final http.Response response = await http.post(
    'http://192.168.43.219:3000/api/v1/auth/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{"username": username, "password": password},
    ),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return UserLoginModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('${response.statusCode} Username or password incorrect');
  }
}
