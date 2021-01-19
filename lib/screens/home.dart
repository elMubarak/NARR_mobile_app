import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:narr/provider/app_data.dart';
import 'package:narr/screens/history.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/widgets/cards.dart';
import 'package:narr/widgets/chart_info.dart';
import 'package:narr/widgets/container_card.dart';
import 'package:narr/widgets/school_dash_card.dart';
import 'package:narr/widgets/search_filter.dart';
import 'dart:async';
import 'package:narr/widgets/menu_drawer.dart';
import 'package:narr/widgets/suggestion_card.dart';
import 'package:provider/provider.dart';
import 'single_file_upload.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.message});
  final dynamic message;
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
  int _counter = 20;

  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
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
    //
    // showSimpleFlushbar(context: context, message: message);
    var data = [
      ClicksPerYear('22', 42, Colors.red),
      ClicksPerYear('52', 52, Colors.yellow),
      ClicksPerYear('75', 80, Color(0xff00a368)),
      ClicksPerYear('34', 32, Colors.blue),
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
    // var chart2 = charts.PieChart(
    //   series,
    //   animate: true,
    // );
    var chartWidget = Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 70.0,
        child: chart,
      ),
    );
    // var chartWidget2 = Container(
    //   height: 35,
    //   child: chart2,
    // );

    List readingHistoryArray =
        Provider.of<AppData>(context, listen: false).userReadingHistoryList;

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
            onPressed: () async {},
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
                  SchoolDashCard(),
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
                  ContainerCard(
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
                        SizedBox(
                          height: 15,
                        ),
                        // Container(
                        //   height: MediaQuery.of(context).size.height * 0.4,
                        //   child: ListView.separated(
                        //     reverse: true,
                        //     itemCount: readingHistoryArray.length,
                        //     separatorBuilder:
                        //         (BuildContext context, int index) => Divider(),
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         contentPadding: EdgeInsets.zero,
                        //         leading: CircleAvatar(
                        //           child: Icon(Icons.insert_drive_file),
                        //         ),
                        //         title: Text(
                        //           '${readingHistoryArray[index]['researchTitle']}',
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //         ),
                        //         subtitle: Text(
                        //           //getting the list of authors and removing the square brackets
                        //           '${readingHistoryArray[index]['authors'].toString().replaceAll('[', '').replaceAll(']', '')}',
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //         ),
                        //         trailing: Column(
                        //           mainAxisAlignment: MainAxisAlignment.end,
                        //           children: [
                        //             Text(
                        //               '${readingHistoryArray[index]['accessType']}',
                        //             ),
                        //             SizedBox(
                        //               height: 5,
                        //             ),
                        //             Text(
                        //               '${readingHistoryArray[index]['nPages']} Pages',
                        //               style: TextStyle(
                        //                 color: Color(0xff00a368),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ContainerCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Suggestions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SugesstionCardContent(),
                        SizedBox(
                          height: 15.0,
                        ),
                        SugesstionCardContent(),
                        SizedBox(
                          height: 15.0,
                        ),
                        SugesstionCardContent(),
                        SizedBox(
                          height: 15.0,
                        ),
                        SugesstionCardContent(),
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
          Navigator.of(context).pushNamed(SingleFileUpload.id);
        },
        label: Text('Upload File'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     HeaderCard(
//       title: 'Documents',
//       count: '22',
//       color: Color(0xff00a368),
//       icon: Icons.insert_drive_file,
//     ),
//     HeaderCard(
//       title: 'Recommendations',
//       count: '15',
//       color: Colors.blue,
//       icon: Icons.book,
//     ),
//   ],
// ),
// SizedBox(height: 15),

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     HeaderCard(
//       title: 'Mentions',
//       count: '30',
//       color: Colors.orange,
//       icon: Icons.person,
//     ),
//     HeaderCard(
//       title: 'Research Work',
//       color: Colors.pink,
//       count: '29',
//       icon: Icons.import_contacts,
//     ),
//   ],
// ),
