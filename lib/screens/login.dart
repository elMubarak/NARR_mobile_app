import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:narr/screens/forgotPassword.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/register.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/formCard.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff00a368),
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'images/bck.svg',
                fit: BoxFit.fill,
              ),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 15),
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
                          TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                            ),
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
                          SizedBox(height: 25.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(HomeScreen.id);
                            },
                            child: CustomBotton(
                              buttonTitle: 'Login',
                            ),
                          ),
                          SizedBox(height: 25.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(Register.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Don\'t have an account?'),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
