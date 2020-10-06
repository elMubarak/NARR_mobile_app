import 'package:flutter/material.dart';
import 'package:narr/screens/forgotPassword.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/register.dart';
import 'package:narr/screens/users.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/formCard.dart';
import 'package:narr/services/loginAuth.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  bool _obscureText = true;

  // Future root() async {
  //   http.Response response = await http.get(
  //     'http://192.168.1.4:3000/',
  //   );

  //   String data = response.body;
  //   var payload = jsonDecode(data)['payload'];
  //   print(payload);
  // }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00a368),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
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
                                  // loginUser();
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  }
                                },
                                child: CustomBotton(
                                  buttonTitle: 'Login',
                                ),
                              ),
                              SizedBox(height: 25.0),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
