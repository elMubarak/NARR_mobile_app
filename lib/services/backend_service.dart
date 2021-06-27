import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/models/citation_mode.dart';
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/admin_dash/admin_add_researcher.dart';
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
  static String tok = '';
  static String email = '';

  final Uri url;
  NetworkHelper({required this.url});

  //registration
// ignore: missing_return
  Future<UserRegistrationModel?> userRegistration({
    required String username,
    required String password,
    required String fname,
    required String lname,
    required String dob,
    required String phone,
    required String address,
    required Map<String, dynamic> institution,
    required BuildContext context,
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
        print(jsonDecode(data));
        _socketService.handleSignupEvent(jsonDecode(data)['payload']);

        Navigator.pushReplacementNamed(context, VerifyAccount.id);
        return UserRegistrationModel.fromData(jsonDecode(response.body));
      } else {
        String data = response.body;
        var message = jsonDecode(data)['message'];
        displayDialog(context, "Failed ❌", "$message");
        print(response.body);
        return UserRegistrationModel.fromData(jsonDecode(response.body));
      }
    } catch (err) {
      displayDialog(context, "Failed ❌", "An Error Occured");
      print(err);
    }
  }

  //function to login a user
  Future loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
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
        print(data);
        // print(data);
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
    required Response response,
    required String selectedfile,
    required Function(int, int) onSendProgress,
    required BuildContext context,
  }) async {
    String uploadurl = url.toString();
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
                selectedFile: '',
                imagePicked: '',
                headers: {},
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
    required Response response,
    required String selectedfile,
    required Function(int, int) onSendProgress,
    required String researchTitle,
    required List<String> authors,
    required List<CitationModel> citation,
    required List<dynamic> category,
    required String genre,
    required String accessType,
    required String fee,
    required String year,
    required String description,
    required Widget trancitionedScreen,
    required String alertMessage,
    required BuildContext context,
  }) async {
    String uploadurl = url.toString();
    dynamic savedUser = await _box.getSavedUser();
    String savedToken = await _box.getSavedToken();

    FormData formdata = FormData.fromMap({
      "meta": jsonEncode(<String, String>{
        "researchTitle": "$researchTitle",
        "authors": "$authors",
        "citations": '$citation',
        "category": "$category",
        'genre': "$genre",
        'accessType': "$accessType",
        'monthlyFee': fee,
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
        print('ERROR UPLOAD ${response.statusCode} ${response.statusMessage}');
      }
    } catch (err) {
      displayDialog(context, "${response.statusCode}\n An Error Occurred",
          "Error Uploading Research");
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
  Future getSingleResearch(String id, String url) async {
    String savedToken = await _box.getSavedToken();
    final Uri uri = Uri.parse('$url/$id');
    try {
      http.Response response = await http.get(
        uri,
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
    final Uri uri = Uri.parse('$serverUrl/research');

    var research =
        await NetworkHelper(url: uri).getSingleResearch(id, currentPage);

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

  //get all institution cate
  Future getInstitutionType() async {
    try {
      http.Response response = await http.get(url);
      dynamic data = response.body;
      var payload = jsonDecode(data)['institutionTypes']['payload'];
      print(payload);
      return payload;
    } catch (error) {
      print("Error getting all institution $error");
    }
  }

  // get all institution
  Future getInstitutionName() async {
    try {
      http.Response response = await http.get(url);
      dynamic data = response.body;
      // print('obj $data');
      List<dynamic> payload = jsonDecode(data)['institutions']['payload'];
      return payload;
    } catch (error) {
      print("Error getting all institution $error");
    }
    return ['null'];
  }

  // get all institution by name
  Future getSingleInstitutionByName(String name) async {
    final Uri uri = Uri.parse('$url?name=$name');

    try {
      http.Response response = await http.get(uri);
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
    final Uri uri = Uri.parse('$url/$id');

    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(
        uri,
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
      {required Response response,
      required String attachmentfile,
      required String from,
      required String to,
      required String subject,
      required String cc,
      required String bcc,
      required BuildContext context}) async {
    String uploadurl = url.toString();

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
    Uri uri = Uri.parse('$url/$id');
    String savedToken = await _box.getSavedToken();
    try {
      http.Response response = await http.get(
        uri,
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

  //add a researcher
  // ignore: missing_return
  Future<UserRegistrationModel?> addResearcher({
    required String username,
    required String password,
    required String fname,
    required String lname,
    required String dob,
    required String phone,
    required String address,
    required Map<String, dynamic> institution,
    required BuildContext context,
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
        var message = jsonDecode(data)['message'];
        displayDialog(context, "Success ✅", "$message");
      } else {
        String data = response.body;
        var message = jsonDecode(data)['message'];
        displayDialog(context, "Failed ❌", "$message");
        print(response.body);
      }
    } catch (err) {
      displayDialog(
          context, "Failed ❌", "An Error Occured, check internent connection");
      print(err);
    }
  }
}
