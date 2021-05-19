import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class Singleresearcher extends StatefulWidget {
  final String researcherId;
  Singleresearcher({this.researcherId});

  @override
  _SingleresearcherState createState() => _SingleresearcherState();
}

class _SingleresearcherState extends State<Singleresearcher> {
  String server = '$serverUrl/user';
  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // print(onlineUsers.numberOfUsersOnline);
    return Scaffold(
      body: FutureBuilder(
        future: NetworkHelper(url: server)
            .getSingleRegisteredUser(widget.researcherId),
        builder: (context, snapshot) {
          var user = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('images/profile.jpg'),
                          radius: 45.0,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['fullName'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['userRole'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ContainerWithShadow(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['fName'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['lName'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.email,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['email'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['phone'],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.house,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['address'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['dob'],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text('Last Login: '),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '20 munites ago',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ContainerWithShadow(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Institution Information',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Image.network(
                              'https://api.narr.ng${user['institution']['logo']}',
                              width: 60,
                            ),
                            SizedBox(width: 5),
                            Text(user['institution']['acronym'])
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.school,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['institution']['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.school,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['institution']['type'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              user['institution']['year'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
