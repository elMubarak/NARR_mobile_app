import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static String id = 'profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('images/musa.jpg'),
                        radius: 50.0,
                      ),
                      Icon(Icons.edit),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 20.0,
                            ),
                            Text(
                              'Musa Jibril',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.email,
                              size: 20.0,
                            ),
                            Text(
                              'musjib999@gmail.com',
                            ),
                          ],
                        ),
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
                            'Bayero University Kano',
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            'Software Enginnering',
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ReuseableCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'My Projects',
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
                        Text('6 Projects'),
                        Projects(
                          title: 'Urban Planning',
                          percentage: '23',
                        ),
                        Projects(
                          title: 'Conflict',
                          percentage: '13',
                        ),
                        Projects(
                          title: 'Covid-19',
                          percentage: '19',
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
          ],
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
      padding: EdgeInsets.symmetric(horizontal: 6),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: Text(
              percentage,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green[700],
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
