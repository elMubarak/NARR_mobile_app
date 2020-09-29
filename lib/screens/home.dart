import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:narr/screens/about.dart';
import 'package:narr/screens/chat.dart';
import 'package:narr/screens/document_convert.dart';
import 'package:narr/screens/history.dart';
import 'package:narr/screens/ocr.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/screens/upload_document.dart';
import 'package:narr/screens/video_conf.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    print('Works');
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // Timer(Duration(seconds: 2), () {
    //   _incrementCounter();
    // });

    runThis();
    super.initState();
  }

  runThis() {
    Timer.periodic(Duration(seconds: 35), (timer) {
      // _incrementCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('20k', 22, Colors.red),
      ClicksPerYear('1M', 52, Colors.yellow),
      ClicksPerYear('$_counter', _counter, Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];
    var chart = charts.BarChart(
      series,
      animate: true,
    );
    var chart2 = charts.PieChart(
      series,
      animate: true,
    );
    var chartWidget = Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 70.0,
        child: chart,
      ),
    );
    var chartWidget2 = Container(
      height: 35,
      child: chart2,
    );
    return Scaffold(
      drawer: Drawer(
        child: DrawerItems(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff00a368),
        title: Text('NARR'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: MediaQuery.of(context).size.height / 2 - 82,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff00a368),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2.5),
                                blurRadius: 8,
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search Research Work',
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Tooltip(
                        message: 'Categories',
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              enableDrag: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => BottomSheet(),
                            );
                          },
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              // boxShadow: [
                              //   BoxShadow(
                              //     offset: Offset(0, 2.5),
                              //     blurRadius: 8,
                              //     color: Colors.black.withOpacity(0.25),
                              //   ),
                              // ],
                            ),
                            child: Icon(Icons.category),
                          ),
                        ),
                      ),
                    ],
                  ), //search and ctgr
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2.5),
                          blurRadius: 8,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Overview'),
                                  Text(
                                    '2019',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                              //charts
                              chartWidget,
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ChartInfoG(
                                    color: Colors.red,
                                    info: 'Downloads',
                                  ),
                                  ChartInfoG(
                                    color: Colors.yellow,
                                    info: 'Review',
                                  ),
                                  ChartInfoG(
                                    color: Colors.green,
                                    info: 'Author endorsed',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'January 15 - Febuary 16',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 25,
                bottom: 15,
              ),
              child: Column(
                children: [
                  Text(
                    'Most Trending Tags',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            Tags(
                              tag: 'Data Science',
                            ),
                            Tags(
                              tag: 'History',
                            ),
                            Tags(
                              tag: 'Research Analysis',
                            ),
                            Tags(
                              tag: 'Fiction',
                            ),
                            Tags(
                              tag: 'Neural Network',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 15,
                      right: 15,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2.4),
                          blurRadius: 5,
                          color: Colors.grey.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recents :',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 10),
                        BookListTile(),
                        BookListTile(),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            child: Text(
                              'More..',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 15,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 15,
                      right: 15,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2.4),
                          blurRadius: 5,
                          color: Colors.grey.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Disscusions :'),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text('Musa Damu'),
                          subtitle: Text('This was Endorsed @SCM'),
                          trailing: Text('View..'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text('Musa Damu'),
                          subtitle: Text('This was Endorsed @SCM'),
                          trailing: Text('View..'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://avatars1.githubusercontent.com/u/53815937?s=460&u=6556c76bfca7a9ec09d299a7fd6b57f014cc05f5&v=4',
                            ),
                          ),
                          title: Text('Musa Damu'),
                          subtitle: Text('This was Endorsed @SCM'),
                          trailing: Text('View..'),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff00a368),
        onPressed: () {
          Navigator.of(context).pushNamed(UploadDoc.id);
        },
        label: Text('Upload File'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
              SizedBox(height: 15),
              Divider(),
              CategoryItem(item: 'History'),
              CategoryItem(item: 'Law'),
              CategoryItem(item: 'Science'),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    this.item,
  }) : super(key: key);
  final String item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          title: Center(
            child: Text('$item'),
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.1),
          height: 1,
        ),
      ],
    );
  }
}

class Tags extends StatelessWidget {
  const Tags({
    Key key,
    this.tag,
  }) : super(key: key);
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.25),
      ),
      child: Text('$tag'),
    );
  }
}

class ChartInfoG extends StatelessWidget {
  const ChartInfoG({
    Key key,
    this.color,
    this.info,
  }) : super(key: key);
  final Color color;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '$info',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class BookListTile extends StatelessWidget {
  const BookListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/proxy/BxKjEydXx5wO6dpCywJcBqXL6VNTh9K69kKRHvSrOcfX1jhNBvt1gHQyn6fr9jqVaeJtIjptDw0Acs9iaFsd-TadY8DOuJLcH0hC88D7vdOmf54yY0fO17BdkToNA-TzIECD4NnzFaX8y7t7h-Y5TWyasjU3EEhBcyQWl1WMw0Kr1lbw8a55UymzGUKHkiQ'),
            ),
            title: Text('SCM Research Analysis'),
            subtitle: Text('Documented Reserch 500 Pages'),
            trailing: Text(
              '₦100',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          Divider(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DrawerHeader(
          child: Container(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://avatars3.githubusercontent.com/u/40618838?s=460&v=4'),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Mubarak Ibrahim',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Benue State University',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Level ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            '400',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Tooltip(
                    message: 'Edit Profile',
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black.withOpacity(0.5),
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xff00a368),
          ),
        ),
        Flexible(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Chat'),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(ChatScreen.id);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('History'),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(History.id);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Document Convertion'),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(DocumentConvert.id);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('OCR'),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(OCRScreen.id);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Video Conferencing'),
                  onTap: () {
                    Navigator.of(context)
                        .popAndPushNamed(VideoConferenceScreen.id);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('About'),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(AboutUs.id);
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(Profile.id);
                    // ...
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.red.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
