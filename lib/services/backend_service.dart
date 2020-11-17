import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:narr/helpers/document_to_pdf.dart';
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

        Navigator.pushReplacementNamed(context, VerifyAccount.id);
        return UserRegistrationModel.fromJson(jsonDecode(response.body));
      } else {
        displayDialog(context, "An Error Occurred",
            "${response.statusCode} Failed to create a user");
      }
    } catch (err) {
      if (err.osError.errorCode == 111) {
        displayDialog(context, "An Error Occurred", "Server not available");
      }
    }
  }

//login

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
        print(response.body);
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        return UserLoginModel.fromJson(jsonDecode(response.body));
      } else {
        displayDialog(context, "An Error Occurred",
            "${response.statusCode} No account was found matching that username and password");
      }
    } catch (err) {
      if (err.osError.errorCode == 111) {
        displayDialog(context, "An Error Occurred", "Server not available");
      }
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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return OcrResult(
            response: response,
          );
        }));
        displayDialog(context, "Success",
            "${basename(selectedfile)} file uploaded successfully");
        //print response from server
      } else {
        print("Error during connection to server.");
      }
    } catch (err) {
      displayDialog(context, "An Error Occurred", "$err");
      Navigator.pushNamed(context, OcrResult.id);
    }
  }

  //upload file

  Future uploadFile({
    Response response,
    String selectedfile,
    Map uploadMeta,
    Function onSendProgress,
    Widget trancitionedScreen,
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
      response = await dio.post(
        uploadurl,
        data: formdata,
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200) {
        print('response >>> $response');
        DocToPDF docToPDF = DocToPDF();
        docToPDF.readFile();
        docToPDF.writeFile(response.data);

        //save path

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return trancitionedScreen;
            },
          ),
        );
        displayDialog(context, "Success",
            "${basename(selectedfile)} file uploaded successfully");
        //print response from server
      } else {
        print("Error during connection to server.");
        print(response.statusMessage);
      }
    } catch (err) {
      displayDialog(context, "An Error Occurred", "$err");
    }
  }
}

// /home/musjib/Documents/Miscellaneous.odt
