import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/services/loginAuth.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/formCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  static String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String dob = '${selectedDate.toLocal()}'.split(' ')[0];
  static String selectedInstitutionType = 'Institution Type';
  static String selectedInstitutionName = 'Institution Name';
  String fname;
  String lname;
  String email;
  String phone;
  String address;
  String password;
  String cPassword;

  static Institution institution =
      Institution(name: selectedInstitutionName, type: selectedInstitutionType);

  var call = institution.toJson();

  bool _obscureText = true;
  bool showSpiner = false;
  final _formKey = GlobalKey<FormState>();

  static DateTime selectedDate = DateTime.now();
  bool isPicked = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        isPicked = true;
      }); //get
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future registerUser() async {
    String json =
        '{"username": "$email", "password": "$password", "fname": "$fname", "lname": "$lname", "phone": "$phone", "address": "$address", "dob": "$dob", "institution": {"type": "${institution.type}", "name": "${institution.name}"}}';

    String decjson = jsonDecode(json);
    http.Response response = await http.post(
      'http://192.168.1.4:3000/api/v1/auth/register',
      body: decjson,
    );
    if (response.statusCode == 200) {
      String data = response.body;

      print(data);
      Navigator.pushReplacementNamed(context, HomeScreen.id);
      return jsonDecode(data);
    } else {
      String data = response.body;
      var message = jsonDecode(data);
      displayDialog(
          context, "An Error Occurred ${response.statusCode} ", "$message");
    }
  }

  List<String> institutionType = [
    'Institution Type',
    'None',
    'Federal University',
    'Federal Poly',
    'State University',
    'State Poly'
  ];
  List<String> institutionName = [
    'ABU',
    'BUK',
    'KASU',
    'KadPoly',
    'FUDMA',
    'ATBU'
  ];
  // getInstitutionType() {
  //   List<DropdownMenuItem<String>> newdropdownItemList = [];
  //   for (var item in institutionType) {
  //     var newInstTypeItem = DropdownMenuItem(
  //       child: Text(item),
  //       value: item,
  //     );
  //     newdropdownItemList.add(newInstTypeItem);
  //   }
  //   return newdropdownItemList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00a368),
      body: ModalProgressHUD(
        inAsyncCall: showSpiner,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                children: <Widget>[
                  Text(
                    'Hello! Researcher ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  FormCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 15),
                          Text(
                            'CREATE ACCOUNT',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Color(0xff00a368),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'First Name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First Name',
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                            ),
                            onChanged: (value) {
                              fname = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Last Name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name',
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                            ),
                            onChanged: (value) {
                              lname = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email is required';
                              } else if (!value.contains('@')) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey[600],
                                    size: 20,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    isPicked ? dob : 'Date of Birth',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone Number',
                              filled: true,
                              prefixIcon: Icon(Icons.phone),
                            ),
                            onChanged: (value) {
                              phone = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Address',
                              filled: true,
                              prefixIcon: Icon(Icons.home),
                            ),
                            onChanged: (value) {
                              address = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          DropdownContainer(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              hint: Text('Institution Type'),
                              value: institution.type,
                              items: [
                                DropdownMenuItem(
                                  child: Text('Institution Type'),
                                  value: 'Institution Type',
                                ),
                                DropdownMenuItem(
                                  child: Text('University'),
                                  value: 'University',
                                ),
                                DropdownMenuItem(
                                  child: Text('Polytechnic'),
                                  value: 'Polytechnic',
                                ),
                                DropdownMenuItem(
                                  child: Text('College Of Education'),
                                  value: 'College Of Education',
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  institution.type = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          DropdownContainer(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              hint: Text('Institution Name'),
                              value: institution.name,
                              items: [
                                DropdownMenuItem(
                                  child: Text('Institution Name'),
                                  value: 'Institution Name',
                                ),
                                DropdownMenuItem(
                                  child: Text('Ahmadu Bello University'),
                                  value: 'Ahmadu Bello University',
                                ),
                                DropdownMenuItem(
                                  child: Text('Bayero University Kano'),
                                  value: 'Bayero University Kano',
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  institution.name = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password less than 6 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(Icons.visibility),
                              ),
                            ),
                            obscureText: _obscureText,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password is required';
                              } else if (password != cPassword) {
                                return 'Passwords not matched';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscureText,
                            onChanged: (value) {
                              cPassword = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  showSpiner = true;
                                });
                                registerUser();

                                setState(() {
                                  showSpiner = false;
                                });
                              }
                            },
                            child: CustomBotton(
                              buttonTitle: 'Register',
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(Login.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Already have an account?'),
                                    SizedBox(width: 5),
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Color(0xff00a368),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownContainer extends StatelessWidget {
  final Widget child;

  DropdownContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: child,
    );
  }
}

class Institution {
  String name;
  String type;
  Institution({this.name, this.type});

  Institution.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'];

  Map<String, String> toJson() => {
        'name': name,
        'type': type,
      };
}
