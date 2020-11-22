import 'package:flutter/material.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class Profile extends StatefulWidget {
  static String id = 'profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      //   backgroundColor: Color(0xff00a368),
      // ),
      body: SafeArea(
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
                          'Mubarak Na Mairo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          'Researcher',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
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
                          'namairo@gmail.com',
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
                          'Ahmadu Bello Univeristy',
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
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
                          'Geography',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ContainerWithShadow(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'All research',
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff00a368),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      child: VerticalDivider(color: Colors.black),
                    ),
                    Column(
                      children: [
                        Text(
                          'Online Users',
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            Text(
                              '536428',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff00a368),
                              ),
                            ),
                            Icon(
                              Icons.person,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ContainerWithShadow(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'My Researches',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Projects(
                      title: 'Urban Planning',
                    ),
                    Projects(
                      title: 'Conflict',
                    ),
                    Projects(
                      title: 'Covid-19',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'See more+',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Projects extends StatelessWidget {
  final String title;
  final String percentage;
  Projects({@required this.title, this.percentage});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Aug 12, 2020',
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
          CircleAvatar(
            child: Icon(Icons.insert_drive_file),
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
