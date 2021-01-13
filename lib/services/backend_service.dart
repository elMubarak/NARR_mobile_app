import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/ocr_result.dart';
import 'package:narr/screens/verify_email.dart';
import 'package:path/path.dart';
import 'package:narr/services/socket_service.dart';
import 'package:narr/store/hive_store.dart';

Future displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
      ),
    );
SocketService _socketService = SocketService();
dynamic userObj;

Dio dio = new Dio();

class NetworkHelper {
  static String tok;
  static dynamic email;

  final String url;
  NetworkHelper({this.url});

  //registration
// ignore: missing_return
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
    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "email": username,
            "password": password,
            "fName": fname,
            "lName": lname,
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
        _socketService.handleSignupEvent(jsonDecode(data)['payload']);

        Navigator.pushReplacementNamed(context, VerifyAccount.id);
        return UserRegistrationModel.fromData(jsonDecode(response.body));
      } else {
        displayDialog(context, "An Error Occurred",
            "${response.statusCode} Failed to create a user");
        print(response.body);
      }
    } catch (err) {
      displayDialog(context, "An Error Occurred", "${err.osError.message}");
      print(err);
    }
  }

// ignore: missing_return
  Future<String> loginUser(
      {String email, String password, BuildContext context}) async {
    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{"email": email, "password": password},
        ),
      );
      HiveBox().saveEmailPassword(email, password);

      if (response.statusCode == 200) {
        String data = response.body;
        userObj = jsonDecode(data)['payload']['user'];
        tok = jsonDecode(data)['payload']['token'];
        var result = HiveBox().addToBox(token: tok, userObj: userObj);
        result.then((value) {
          //socket authentication
          _socketService.connectToSocketServer();
          _socketService.handleLoginEvent(
            context: context,
            token: value['savedToken'],
            user: value['savedUser'],
          );
        });

        //api.narr.ng   events 'EVENT:USER:LOGIN' and 'LOGIN'
        Navigator.pushNamed(context, HomeScreen.id);

        return data;
      } else if (response.statusCode == 403) {
        String data = response.body;
        var message = jsonDecode(data)['message'];
        print(data);
        displayDialog(
            context, "An Error Occurred", "${response.statusCode} $message");
      } else {
        displayDialog(context, "An Error Occurred",
            "${response.statusCode} No account was found matching that username and password");
      }
      //loading to false
    } catch (err) {
      displayDialog(context, "An Error Occurred",
          "${err.osError.message} server not available");
      print(err);
    }
    // isLoading = false;
  }

  // get user profile
  HiveBox _box = HiveBox();

  //upload image
  Future uploadPhoto({
    Response response,
    String selectedfile,
    Function onSendProgress,
    BuildContext context,
  }) async {
    String uploadurl = url;
    String savedToken = await _box.getUser('token');
    FormData formdata = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        selectedfile,
        filename: basename(selectedfile),
        // contentType: MediaType.parse('text/plain'),
      ),
    });
    try {
      response = await dio.post(
        uploadurl,
        data: formdata,
        onSendProgress: onSendProgress,
        options: Options(
            headers: {'Accept': 'text/plain', 'x-token': '$savedToken'}),
      );

      if (response.statusCode == 200) {
        print('response ${response.toString()}');
        print(response.statusMessage);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OcrResult(
                response: response,
              );
            },
          ),
        );
        displayDialog(context, "Success",
            "${basename(selectedfile)} file converted successfully");
        //print response from server
      } else {
        print("Error Converting to text");
      }
    } catch (err) {
      print(err);
      displayDialog(
          context, "An Error Occurred", "Error while converting to text");
    }
  }

  //upload file
  var httpClient = http.Client();
  String uploadToken = tok;
  String uploadEmail = email;

  Future uploadFile({
    Response response,
    String selectedfile,
    Function onSendProgress,
    String researchTitle,
    String authors,
    String category,
    String genre,
    String accessType,
    String fee,
    String year,
    String description,
    Widget trancitionedScreen,
    String alertMessage,
    BuildContext context,
  }) async {
    String uploadurl = url;
    dynamic savedUser = await _box.getUser('user');
    String savedToken = await _box.getUser('token');

    FormData formdata = FormData.fromMap({
      "meta": jsonEncode(<String, String>{
        "researchTitle": "$researchTitle",
        "authors": "$authors",
        "category": "$category",
        'genre': "$genre",
        'accessType': "$accessType",
        'monthlyFee': fee == null ? "0" : fee,
        'year': '$year',
        'ownerEmail': "${savedUser['email']}",
        'description': "$description",
      }),
      "file": await MultipartFile.fromFile(
        selectedfile,
        filename: basename(selectedfile),
      ),
    });
    try {
      // var responsez = httpClient.send(request);

      // print('the upload token >> $uploadToken and email >> ${userObj}');
      print('Saved user email ${savedUser['email']}');
      response = await dio.post(
        uploadurl,
        data: formdata,
        onSendProgress: onSendProgress,
        options: Options(headers: {
          'x-token': '$savedToken',
        }),
      );

      if (response.statusCode == 200) {
        print(response.statusMessage);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return trancitionedScreen;
            },
          ),
        );
        displayDialog(
            context, "Success", "${basename(selectedfile)} $alertMessage");
        //print response from server
      } else {
        print(response.statusMessage);
      }
    } catch (err) {
      displayDialog(context, "An Error Occurred", "Error Uploading Research");
      print(err);
    }
  }

  Future getAllResearch() async {
    String savedToken = await _box.getUser('token');
    try {
      http.Response response = await http.get(url, headers: {
        'x-token': '$savedToken',
      });
      String data = response.body;
      var payload = jsonDecode(data)['payload'];
      return payload;
    } catch (error) {
      print("Error getting all researches $error");
    }
  }

  //get one contact
  Future getSingleResearch(String id) async {
    String savedToken = await _box.getUser('token');
    try {
      http.Response response = await http.get(
        '$url/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-token': '$savedToken',
        },
      );
      var data = response.body;
      var payload = jsonDecode(data);

      return payload;
    } catch (e) {
      print("Error getting single research $e");
    }
  }
}

// /home/musjib/Documents/Miscellaneous.odt
