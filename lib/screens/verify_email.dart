import 'package:flutter/material.dart';

class VerifyAccount extends StatefulWidget {
  static String id = 'verify account';
  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00a368),
        title: Text('Verify Account'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Dear Mubarak \nMairo you have registered successfully, please verify your account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text('Your account information are: '),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 20.0,
                ),
                Text(
                  'Mubarak Na mairo',
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.email,
                  size: 20.0,
                ),
                Text(
                  'namairo006@gmail.com',
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.school,
                  size: 20.0,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  'Bayero University Kano',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
