import 'package:flutter/material.dart';

class NarrUsers extends StatefulWidget {
  static String id = 'NarrUsers';
  @override
  _NarrUsersState createState() => _NarrUsersState();
}

class _NarrUsersState extends State<NarrUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Users'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Users',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UserData();
                  }));
                },
                child: Text('Fetch Users'),
              ),
              RaisedButton(
                onPressed: () {
                  // loginUser();
                },
                child: Text('Refresh token'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Users'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Users',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                // future: loginUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(child: Text(snapshot.data));
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
