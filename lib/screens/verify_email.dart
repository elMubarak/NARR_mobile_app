import 'package:flutter/material.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/custom_button.dart';

class VerifyAccount extends StatefulWidget {
  static String id = 'verify account';
  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00a368),
      appBar: AppBar(
        backgroundColor: Color(0xff00a368),
        title: Text('Verify Account'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ContainerWithShadow(
                child: Column(
                  children: [
                    Text(
                      'Congratulations',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Thank you for Signing up with Narr please verify your account',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBotton(
                      isLoading: false,
                      buttonTitle: 'Login',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Login.id);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
