import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:narr/screens/history.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/screens/upload_document.dart';
import 'package:narr/widgets/cards.dart';
import 'package:narr/widgets/chart_info.dart';
import 'package:narr/widgets/search_filter.dart';
import 'dart:async';
import 'package:narr/widgets/menu_drawer.dart';

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
            onPressed: () {
              Navigator.of(context).pushNamed(Profile.id);
            },
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
              // height: MediaQuery.of(context).size.height * 0.100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff00a368),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  SizedBox(height: 15),

                  Container(
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
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Research Work',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ), //search and ctgr
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HeaderCard(
                        title: 'Documents',
                        count: '22',
                        color: Color(0xff00a368),
                        icon: Icons.insert_drive_file,
                      ),
                      HeaderCard(
                        title: 'Recomendations',
                        count: '15',
                        color: Colors.blue,
                        icon: Icons.book,
                      ),
                      HeaderCard(
                        title: 'Mentions',
                        count: '30',
                        color: Colors.orange,
                        icon: Icons.person,
                      ),
                      HeaderCard(
                        title: 'Research Work',
                        color: Colors.pink,
                        count: '29',
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
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
                              'Reading History',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(History.id);
                              },
                              child: Text(
                                'View More..',
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            child: Icon(Icons.insert_drive_file),
                          ),
                          title: Text('Medical Research'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Color(0xff00a368),
                                value: 2,
                              ),
                              SizedBox(height: 5),
                              Text('12/08/2020')
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
                          leading: CircleAvatar(
                            child: Icon(Icons.insert_drive_file),
                          ),
                          title: Text('Fintech grant work'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Color(0xff00a368),
                                value: 2,
                              ),
                              SizedBox(height: 5),
                              Text('12/08/2020')
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
                          leading: CircleAvatar(
                            child: Icon(Icons.insert_drive_file),
                          ),
                          title: Text('The scm wireOs'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Color(0xff00a368),
                                value: 2,
                              ),
                              SizedBox(height: 5),
                              Text('12/08/2020')
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
                          leading: CircleAvatar(
                            child: Icon(Icons.insert_drive_file),
                          ),
                          title: Text('The scm wireOs'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Color(0xff00a368),
                                value: 2,
                              ),
                              SizedBox(height: 5),
                              Text('12/08/2020')
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
                          leading: CircleAvatar(
                            child: Icon(Icons.insert_drive_file),
                          ),
                          title: Text('The scm wireOs'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LinearProgressIndicator(
                                backgroundColor: Color(0xff00a368),
                                value: 2,
                              ),
                              SizedBox(height: 5),
                              Text('12/08/2020')
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
