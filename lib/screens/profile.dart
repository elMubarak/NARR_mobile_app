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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/musa.jpg',
                    width: 70.0,
                  ),
                  Icon(Icons.edit),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Musa Jibril',
                    style: TextStyle(fontSize: 28.0),
                  ),
                  Text('musjib999@gmail.com'),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.school),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        'Bayero University Kani',
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        'Software Enginnering',
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ],
                  ),
                ],
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
  Projects({@required this.title});
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
            backgroundImage: AssetImage('images/musa.jpg'),
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
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
