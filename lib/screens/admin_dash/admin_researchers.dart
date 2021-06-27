import 'package:flutter/material.dart';
import 'package:narr/screens/admin_dash/admin_add_researcher.dart';
import 'package:narr/screens/admin_dash/admin_single_researchers.dart';
import 'package:narr/services/backend_service.dart';

import '../../configs.dart';

class Researchers extends StatefulWidget {
  static String id = '/admin/researchers';
  @override
  _ResearchersState createState() => _ResearchersState();
}

class _ResearchersState extends State<Researchers> {
  Uri myUrl = Uri.parse('$serverUrl/user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Researchers',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<dynamic>(
        future: NetworkHelper(url: myUrl).getAllRegisteredUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var user = snapshot.data[index];
              return ListTile(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Singleresearcher(
                          researcherId: user['_id'],
                        );
                      },
                    ),
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
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
        onPressed: () => Navigator.pushNamed(context, AddResearcher.id),
      ),
    );
  }
}
