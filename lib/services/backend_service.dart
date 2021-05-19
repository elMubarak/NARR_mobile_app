import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
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
List readingHistoryArr = [];

Dio dio = new Dio();

class NetworkHelper {
  static String tok;
  static dynamic email;

  final String url;
  NetworkHelper({this.url});

  //registration
// ignore: missing_return
  Future<UserRegistrationModel> userRegistration({
    String username,
    String password,
    String fname,
    String lname,
    String dob,
    String phone,
    String address,
    Map<String, dynamic> institution,
    // String institutionType,
    // String institutionName,
    BuildContext context,
  }) async {
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
            "institution": institution,
          },
        ),
      );

      if (response.statusCode == 200) {
        String data = response.body;
        _socketService.handleSignupEvent(jsonDecode(data)['payload']);

        Navigator.pushReplacementNamed(context, VerifyAccount.id);
        return UserRegistrationModel.fromData(jsonDecode(response.body));
      } else {
        String data = response.body;
        var message = jsonDecode(data)['message'];
        displayDialog(context, "Failed ❌", "$message");
        print(response.body);
      }
    } catch (err) {
      displayDialog(context, "Failed ❌", "An Error Occured");
      print(err);
    }
  }

  //function to login a user
  Future loginUser(
      {String email, String password, BuildContext context}) async {
    try {
      //making post request to a server
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //Encoding email and password and also sending to server
        body: jsonEncode(
          <String, dynamic>{"email": email, "password": password},
        ),
      );

      //checking for success
      if (response.statusCode == 200) {
        var res = response.body;
        //decoding response and getting token and user object from response
        var data = jsonDecode(res);
        String token = data['payload']['token'];
        Map<String, dynamic> userObj =
            Map<String, dynamic>.from(data['payload']['user']);

        //saving the token and user object to local storage
        //
        HiveBox().saveToken(token);
        HiveBox().saveUser(userObj);
        // await HiveBox().addToBox(token: token, userObj: userObj);

        //connecting to socket, emitting an even that is sending the local token and userobject to the socket server and listening for events

        //navigating to a dasboard

        Navigator.pushReplacementNamed(context, determineDasboard(context));

        //checking for other status codes
        return data;
      } else {
        String data = response.body;
        var message = jsonDecode(data)['message'];
        print(data);
        displayDialog(context, "Failed ❌", "$message");
        return data;
      }
      //loading to false
    } catch (err) {
      // displayDialog(context, "An Error Occurred", "Server not available");
      print("Error from http >>>$err");
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
    String savedToken = await _box.getSavedToken();
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
        displayDialog(context, "Success ✅",
            "${basename(selectedfile)} file converted successfully");
        //print response from server
      } else {
        print("Error Converting to text");
      }
    } catch (err) {
      print(err);
      displayDialog(context, "Failed ❌", "Error while converting to text");
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
    dynamic savedUser = await _box.getSavedUser();
    String savedToken = await _box.getSavedToken();

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

        displayDialog(
            context, "Success ✅", "${basename(selectedfile)} $alertMessage");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return trancitionedScreen;
            },
          ),
        );
        //print response from server
      } else {
        print(response.statusMessage);
      }
    } catch (err) {
      displayDialog(context, "An Error Occurred", "Error Uploading Research");
      print(err);
    }
  }

  //get all researches
  Future getAllResearch() async {
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(url, headers: {
        'x-token': '$savedToken',
      });
      if (response.statusCode == 200) {
        var data = response.body;
        var payload = jsonDecode(data)['payload'];
        print(jsonDecode(data));
        return payload;
      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (error) {
      print("Error getting all researches $error");
    }
  }

  //get one research
  Future getSingleResearch(String id) async {
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(
        '$url/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-token': '$savedToken',
        },
      );
      if (response.statusCode == 200) {
        var data = response.body;
        var payload = jsonDecode(data)['payload'];

        return payload;
      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (e) {
      print("Error getting single research $e");
    }
  }

  //add reading history
  Future addDocumentToResearchHistoryArr({id, currentPage}) async {
    var research =
        await NetworkHelper(url: '$serverUrl/research').getSingleResearch(id);

    Map<String, dynamic> researchObj = {
      "researchTitle": research['research']['researchTitle'],
      "authors": research['research']['authors'],
      "accessType": research['research']['accessType'],
      "nPages": research['research']['nPages']
    };
    readingHistoryArr = readingHistory.readingHistoryDocument;
    if (currentPage == 1) {
      readingHistoryArr.add(researchObj);
      readingHistory.getReadingHistory(readingHistoryArr);
    }
    if (currentPage == research['research']['nPages']) {
      readingHistoryArr.remove(researchObj);
      readingHistory.getReadingHistory(readingHistoryArr);
    }
    print(readingHistory.readingHistoryDocument);

    return researchObj;
  }

  //get all institution type
  Future getInstitutionType() async {
    try {
      http.Response response = await http.get(url);
      String data = response.body;
      var payload = jsonDecode(data)['institutionTypes']['payload'];

      return payload;
    } catch (error) {
      print("Error getting all institution $error");
    }
  }

  // get all institution name
  Future getInstitutionName() async {
    try {
      http.Response response = await http.get(url);
      String data = response.body;
      var payload = jsonDecode(data)['institutions']['payload'];
      return payload;
    } catch (error) {
      print("Error getting all institution $error");
    }
  }

  // get all institution name
  Future getSingleInstitutionByName(String name) async {
    try {
      http.Response response = await http.get('$url?name=$name');
      if (response.statusCode == 200) {
        var data = response.body;
        var payload = jsonDecode(data);

        return payload;
      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (e) {
      print("Error getting single research $e");
    }
  }

  //get all ict works
  Future getAllIctWorks() async {
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(url, headers: {
        'x-token': '$savedToken',
      });
      if (response.statusCode == 200) {
        var res = response.body;
        //decoding response and getting token and user object from response
        var data = jsonDecode(res)['feeds']['payload'];
        print(jsonDecode(res));
        return data;
        //checking for other status codes

      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (error) {
      print("Error getting all ict works $error");
    }
  }

  //get all mails
  Future getAllMail() async {
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(url, headers: {
        'x-token': '$savedToken',
      });
      if (response.statusCode == 200) {
        var res = response.body;
        //decoding response and getting token and user object from response
        var data = jsonDecode(res);
        print(jsonDecode(res));
        return data;
        //checking for other status codes

      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (error) {
      print("Error getting all mails $error");
    }
  }

  //get single mail
  Future getSingleMail(String id) async {
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(
        '$url/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-token': '$savedToken',
        },
      );
      if (response.statusCode == 200) {
        var data = response.body;
        var payload = jsonDecode(data);

        return payload;
      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (e) {
      print("Error getting single research $e");
    }
  }

  //send a mail
  Future sendMail(
      {Response response,
      String attachmentfile,
      String from,
      String to,
      String subject,
      String cc,
      String bcc,
      BuildContext context}) async {
    String uploadurl = url;

    String savedToken = await _box.getSavedToken();

    FormData formdata = FormData.fromMap({
      "meta": jsonEncode(<String, String>{
        "researchTitle": "$from",
        "authors": "$to",
        "category": "$subject",
        'genre': "$cc",
        'accessType': "$bcc",
      }),
      "file": await MultipartFile.fromFile(
        attachmentfile,
        filename: basename(attachmentfile),
      ),
    });
    try {
      response = await dio.post(
        uploadurl,
        data: formdata,
        // onSendProgress: onSendProgress,
        options: Options(headers: {
          'x-token': '$savedToken',
        }),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        var payload = jsonDecode(data);
        print(payload);
        return payload;
      } else {
        String data = response.data;
        print(data);

        return data;
      }
    } catch (err) {
      displayDialog(context, "Failed ❌", "Error Sending mail");
      print(err);
    }
  }

  //admin routes

  //getting all registered users
  Future getAllRegisteredUser() async {
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(url, headers: {
        'x-token': '$savedToken',
      });
      if (response.statusCode == 200) {
        var data = response.body;
        var payload = jsonDecode(data)['payload'];
        return payload;
      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (error) {
      print("Error getting all researches $error");
    }
  }

  //get one research
  Future getSingleRegisteredUser(String id) async {
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(
        '$url/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-token': '$savedToken',
        },
      );
      if (response.statusCode == 200) {
        var data = response.body;
        var payload = jsonDecode(data)['payload'];
        return payload;
      } else {
        String data = response.body;
        print(data);

        return data;
      }
    } catch (e) {
      print("Error getting single research $e");
    }
  }
}
