import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:narr/screens/about.dart';
import 'package:narr/screens/chat.dart';
import 'package:narr/screens/document_convert.dart';
import 'package:narr/screens/ocr.dart';
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
        centerTitle: true,
        actions: [
          IconButton(
            padding: EdgeInsets.all(2),
            alignment: Alignment.centerRight,
            tooltip: 'Notifications',
            icon: Icon(
              Icons.account_circle,
            ),
            onPressed: () {},
          ),
          IconButton(
            padding: EdgeInsets.all(2),
            tooltip: 'Notifications',
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: MediaQuery.of(context).size.height / 2 + 10,
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
                            child: Icon(
                              Icons.format_list_numbered,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), //search and ctgr
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 85,
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        HeaderCard(
                          title: 'Documents',
                          count: '22',
                          color: Color(0xff00a368),
                        ),
                        HeaderCard(
                          title: 'Recomendations',
                          count: '15',
                          color: Colors.blue,
                        ),
                        HeaderCard(
                          title: 'Mentions',
                          count: '30',
                          color: Colors.orange,
                        ),
                        HeaderCard(
                          title: 'Research Work',
                          color: Colors.pink,
                          count: '29',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Analytics(chartWidget: chartWidget),
                ],
              ),
            ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reading List',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'View More..',
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text('Medical Research'),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Color(0xff00a368),
                                value: 2,
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Resume'),
                            ],
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text('Fintech grant work'),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Color(0xff00a368),
                                value: 2,
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Resume'),
                            ],
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text('The scm wireOs'),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color(0xff00a368),
                                ),
                                backgroundColor: Colors.white,
                                value: 1,
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Resume'),
                            ],
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text('The scm wireOs'),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color(0xff00a368),
                                ),
                                backgroundColor: Colors.white,
                                value: 1,
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Resume'),
                            ],
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text('The scm wireOs'),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color(0xff00a368),
                                ),
                                backgroundColor: Colors.white,
                                value: 1,
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Resume'),
                            ],
                          ),
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

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key key,
    this.title,
    this.count,
    this.onTap,
    this.color,
  }) : super(key: key);
  final String title;
  final String count;
  final Function onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 90,
            height: 70,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2.5),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: color,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$title',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Analytics extends StatelessWidget {
  const Analytics({
    Key key,
    @required this.chartWidget,
  }) : super(key: key);

  final Padding chartWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    return Container(
      height: 10,
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            color: Color(0xff00a368),
            child: Center(
              child: Text(
                'NARR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
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
      ),
    );
  }
}
