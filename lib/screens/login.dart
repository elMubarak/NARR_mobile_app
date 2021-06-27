import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/forgotPassword.dart';
import 'package:narr/screens/register.dart';
import 'package:narr/screens/register_organisations.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/services/socket_service.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/formCard.dart';

//! import 'home.dart';

String email = '';
String password = '';

class Login extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;
  bool showSpiner = false;
  bool isClickable = false;
  Uri loginUrl = Uri.parse('$serverUrl/auth/login');

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SocketService _socketService = SocketService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff00a368),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FormCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Image.asset(
                          'images/logo-narr.png',
                          width: 200,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xff00a368),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
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
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
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
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ForgotPassword.id);
                            },
                            child: Text(
                              'forgot Password ? ',
                              style: TextStyle(
                                color: Colors.grey[500],
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        CustomBotton(
                          isLoading: isClickable,
                          buttonTitle: 'Login',
                          onTap: () async {
                            setState(() {});
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              setState(() {
                                isClickable = true;
                              });

                              await NetworkHelper(url: loginUrl)
                                  .loginUser(
                                      email: email,
                                      password: password,
                                      context: context)
                                  .then((value) {
                                print(value);

                                setState(() {
                                  isClickable = false;
                                });
                                currentUser = UserModel.fromJson(
                                    value['payload']['user']);
                                Navigator.pushReplacementNamed(
                                    context, determineDasboard(context));

                                _socketService.handleLoginEvent(
                                  token: value['payload']['token'],
                                  user: value['payload']['user'],
                                  context: context,
                                );

                                Navigator.pushReplacementNamed(
                                    context, determineDasboard(context));
                              });
                            }
                            setState(() {});
                          },
                          buttonColor: Color(0xff00a368),
                        ),
                        SizedBox(height: 30.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Register.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('New researcher? '),
                                  SizedBox(width: 5),
                                  Text(
                                    'Register',
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
                        SizedBox(height: 15.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(RegisterOrg.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('New Organisation? '),
                                  SizedBox(width: 5),
                                  Text(
                                    'Register',
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
    );
  }
}
