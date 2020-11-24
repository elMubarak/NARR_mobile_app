import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/ocr_result.dart';
import 'package:narr/screens/verify_email.dart';
import 'package:path/path.dart';

Future displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
      ),
    );

Dio dio = new Dio();

class NetworkHelper {
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
        print(data);

        Navigator.pushReplacementNamed(context, VerifyAccount.id);
        return UserRegistrationModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 500) {
        displayDialog(context, "An Error Occurred",
            "${response.statusCode} Failed to create a user");
        print(response.body);
      }
    } catch (err) {
      // displayDialog(context, "An Error Occurred", "Server not available");
      print(err);
    }
  }

//xbjn

// ignore: missing_return
  Future<UserLoginModel> loginUser(
      String email, String password, BuildContext context) async {
    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"email": email, "password": password},
        ),
      );

      if (response.statusCode == 200) {
        String data = response.body;
        print(data);
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        return UserLoginModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 403) {
        String errMessage = response.body;
        var message = jsonDecode(errMessage)['message'];
        print(errMessage);
        displayDialog(
            context, "An Error Occurred", "${response.statusCode} $message");
      } else {
        displayDialog(context, "An Error Occurred",
            "${response.statusCode} No account was found matching that username and password");
      }
    } catch (err) {
      displayDialog(context, "An Error Occurred",
          "${err.osError.message} server not available");
      print(err);
    }
  }

  //upload image
  Future uploadPhoto({
    Response response,
    String selectedfile,
    Function onSendProgress,
    Map headers,
    BuildContext context,
  }) async {
    String uploadurl = url;
    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
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
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('response ${response.toString()}');
        print(response.data);
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
      displayDialog(context, "An Error Occurred", "$err");
    }
  }

  //upload file
  var httpClient = http.Client();

  Future uploadFile({
    Response response,
    String selectedfile,
    Map uploadMeta,
    Function onSendProgress,
    Widget trancitionedScreen,
    String alertMessage,
    BuildContext context,
  }) async {
    String uploadurl = url;
    FormData formdata = FormData.fromMap({
      "meta": uploadMeta,
      "file": await MultipartFile.fromFile(
        selectedfile,
        filename: basename(selectedfile),
      ),
    });
    try {
      // var responsez = httpClient.send(request);
      response = await dio.post(
        uploadurl,
        data: formdata,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200) {
        print(response.runtimeType);
        // docToPDF.readFile();
        //save path

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
        print("Error during connection to server.");
        print(response.statusMessage);
      }
    } catch (err) {
      displayDialog(context, "An Error Occurred", "$err");
    }
  }

  Future getAllResearch() async {
    http.Response response = await http.get(url);
    String data = response.body;
    var payload = jsonDecode(data)['payload'];

    return payload;
  }

  //get one contact
  Future getSingleResearch(int id) async {
    http.Response response = await http.get(
      '$url/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = response.body;
    var payload = jsonDecode(data);

    print(id);
    return payload;
  }
}

// /home/musjib/Documents/Miscellaneous.odt
