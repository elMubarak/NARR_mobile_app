import 'package:flutter/material.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/register.dart';
import 'package:narr/widgets/custom_button.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00a368),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2.5),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    filled: true,
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
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(HomeScreen.id);
                  },
                  child: CustomBotton(
                    buttonTitle: 'Login',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(Register.id);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xff00a368),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'forgot Password?',
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
    );
  }
}
