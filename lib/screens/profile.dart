import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:narr/provider/app_data.dart';
import 'package:narr/screens/chat.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/store/hive_store.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static String id = 'profile';
  // final String email;
  // final String password;
  // Profile({this.email, this.password});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  HiveBox _box = HiveBox();

  Future getStoredUserObject() async {
    dynamic savedUser = await _box.getUser('user');
    return savedUser;
  }

  @override
  initState() {
    super.initState();
  }

  List newUserList = [];

  fetchUsers() async {
    List onlineUsersArray =
        Provider.of<AppData>(context, listen: false).usersOnlineList;
    // print(onlineUsersArray);
    for (var user in onlineUsersArray) {
      var fullName = user['fullName'];
      // var email = user['email'];
      final onlineUserInfoWidget = GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ChatScreen.id);
        },
        child: Users(
          name: fullName,
          userImage: 'images/profile.jpg',
        ),
      );
      setState(() {
        // usersOnlineWidgets.add(onlineUserInfoWidget);
      });
    }
  }

  Widget build(BuildContext context) {
    fetchUsers();
    return Scaffold(
      body: FutureBuilder(
        future: getStoredUserObject(),
        builder: (context, snapshot) {
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
                        onPressed: () {
                          // Navigator.pushNamed(context, EditProfile.id);
                          setState(() {
                            newUserList.clear();
                          });
                        },
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/profile.jpg'),
                                radius: 45.0,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['fullName'],
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
                                    snapshot.data['userRole'],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
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
                                    snapshot.data['email'],
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
                                    Icons.domain,
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    snapshot.data['institution']['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
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
                                    snapshot.data['phone'],
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
                                    snapshot.data['address'],
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
                                    snapshot.data['dob'],
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
                                    snapshot.data['updatedAt'], //for now
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ContainerWithShadow(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Users Online',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${newUserList.length} Online',
                              style: TextStyle(
                                color: Color(0xff00a368),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Users(
                                name: newUserList[index],
                              );
                            },
                            itemCount: newUserList.length,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  //
                  // ContainerWithShadow(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: <Widget>[
                  //           Text(
                  //             'My Researches',
                  //             style: TextStyle(
                  //               fontSize: 18.0,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 15,
                  //       ),
                  //       Projects(
                  //         title: 'Urban Planning',
                  //       ),
                  //       Projects(
                  //         title: 'Conflict',
                  //       ),
                  //       Projects(
                  //         title: 'Covid-19',
                  //       ),
                  //       SizedBox(
                  //         height: 30,
                  //       ),
                  //       Text(
                  //         'See more+',
                  //         style: TextStyle(color: Colors.blue),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Users extends StatelessWidget {
  final String name;
  final String institution;

  final String userImage;
  Users({@required this.name, this.institution, this.userImage});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 15),
      // height: 65,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 180,
                child: Text(
                  (name != null) ? name : '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                width: 130,
                child: Text(
                  'Online',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff00a368),
                  ),
                ),
              ),
            ],
          ),
          CircleAvatar(
            child: (userImage != null)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset((userImage != null) ? userImage : ''))
                : Icon(Icons.person),
            backgroundColor: Color(0xff00a368),
          ),
        ],
      ),
    );
  }
}

class ReuseableCard extends StatelessWidget {
  final Widget child;
  ReuseableCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
