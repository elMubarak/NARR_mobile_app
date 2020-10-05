import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:narr/models/user_model.dart';

final _base = "http:/192.168.1.4:3000/api/v1";
final _tokenEndpoint = "/auth/login";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      userLogin.toJson(),
    ),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
