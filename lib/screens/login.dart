import 'package:flutter/material.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:narr/screens/forgotPassword.dart';
import 'package:narr/screens/register.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/formCard.dart';
import 'package:narr/services/backend_service.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  bool _obscureText = true;
  bool showSpiner = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00a368),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome Back \n Researcher',
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xff00a368),
                          ),
                        ),
                        SizedBox(height: 15),
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
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              setState(() {
                                showSpiner = true;
                              });

                              NetworkHelper(
                                      url:
                                          'http://192.168.88.41:3000/api/v1/auth/login')
                                  .loginUser(email, password, context);

                              setState(() {
                                showSpiner = false;
                              });
                              // loginUser();
                            }
                          },
                          child: CustomBotton(
                            buttonTitle: 'Login',
                          ),
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
                                  Text('Do not have an account'),
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
