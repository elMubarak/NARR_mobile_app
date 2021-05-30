import 'package:flutter/material.dart';
import 'package:narr/services/backend_service.dart';

import '../../configs.dart';

class Administrators extends StatefulWidget {
  static String id = '/admin/Administrators';
  @override
  _AdministratorsState createState() => _AdministratorsState();
}

class _AdministratorsState extends State<Administrators> {
  String myUrl = '$serverUrl/user';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Administrators',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: NetworkHelper(url: myUrl).getAllRegisteredUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              var user = snapshot.data[index];
              return user['userRole'] == 'admin'
                  ? ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('images/profile.jpg'),
                      ),
                      title: Text('${user['fullName']}'),
                      subtitle: Text('${user['email']}'),
                      trailing: Text(
                        '${user['status']}',
                        style: TextStyle(
                          color: user['status'] == 'active'
                              ? Color(0xff00a368)
                              : Colors.red,
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return Singleresearcher(
                        //         researcherId: user['_id'],
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                    )
                  : Container();
            },
            itemCount: snapshot.data.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        onPressed: null,
      ),
    );
  }
}
