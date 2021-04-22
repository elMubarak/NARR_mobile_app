import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narr/provider/online_users_mobx.dart';
import 'package:narr/provider/reading_history_mobx.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/store/hive_store.dart';
import 'package:narr/widgets/cards.dart';
import 'package:narr/widgets/chart_info.dart';
import 'package:narr/widgets/container_card.dart';
import 'package:narr/widgets/reading_history_card.dart';
import 'package:narr/widgets/school_dash_card.dart';
import 'dart:async';
import 'package:narr/widgets/menu_drawer.dart';
import 'package:narr/widgets/suggestion_card.dart';
import 'package:narr/widgets/trending_card.dart';
import 'package:narr/widgets/users_online_card.dart';
import 'single_file_upload.dart';

final onlineUsers = OnlineUsers();
final readingHistory = ReadingHistory();

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

  HiveBox _box = HiveBox();
  // final _refreshKey = GlobalKey<RefreshIndicatorState>();
  List readingHistoryArry = [];
  // Future<void> getReadingHistory() async {
  //   _refreshKey.currentState?.show();
  //   await Future.delayed(Duration(seconds: 2));
  //   setState(() {
  //     readingHistoryArry = readingHistory.readingHistoryDocument;
  //   });
  // }

  Widget build(BuildContext context) {
    // getReadingHistory();
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
    var chartWidget = Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 70.0,
        child: chart,
      ),
    );

    Future getStoredUserObject() async {
      dynamic savedUser = await _box.getUser('user');
      return savedUser;
    }

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
            onPressed: () async {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff00a368),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    // height: 50,
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
                        hintText: 'Search NARR',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ), //search and ctgr

                  SizedBox(height: 25),
                  SchoolDashCard(
                    institutionLogo:
                        'https://banner2.cleanpng.com/20180423/ohw/kisspng-ahmadu-bello-university-kano-higher-education-scho-university-logo-5addf5f3546bc3.9903414015244958593458.jpg',
                    institutionName: 'Ahmadu Bello University,Zaria',
                    institutionAcronym: 'ABU',
                    studentNo: 1202,
                    onTap: () {},
                  ),
                  // SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ContainerCard(
                child: Column(
                  children: [
                    Text('Activities'),
                    Divider(thickness: 1.2),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderCard(
                          title: 'Documents \nUploaded',
                          count: '22',
                          color: Color(0xff00a368),
                          icon: Icons.insert_drive_file,
                        ),
                        HeaderCard(
                          title: 'Read \nSuggestions',
                          count: '22',
                          color: Colors.blue,
                          icon: Icons.import_contacts,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderCard(
                            title: 'Mentions',
                            info: 'Mentions in the last 1 year',
                            count: '22',
                            color: Colors.orange,
                            icon: Icons.person),
                        HeaderCard(
                          title: 'Research Grants',
                          count: '22',
                          color: Colors.red,
                          icon: Icons.insert_drive_file,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: getStoredUserObject(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Observer(builder: (_) {
                  return UsersOnlineCard(
                    usersOnline: onlineUsers.numberOfUsersOnline.length,
                    userName: snapshot.data['fullName'],
                    userEmail: snapshot.data['email'],
                    onTap: () {
                      Navigator.of(context).pushNamed(Profile.id);
                    },
                  );
                });
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                children: [
                  ReadingHistoryCard(
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print(readingHistory.readingHistoryDocument[index]
                              ['researchTitle']);
                          return (readingHistory.readingHistoryDocument.length <
                                  1)
                              ? Text('No Reading History Yet')
                              : ListTile(
                                  leading: CircleAvatar(
                                    child: Icon(Icons.insert_drive_file),
                                  ),
                                  title: Text(
                                    '${readingHistory.readingHistoryDocument[index]['researchTitle']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                      '${readingHistory.readingHistoryDocument[index]['authors'].toString().replaceAll('[', '').replaceAll(']', '')}'),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        '${readingHistory.readingHistoryDocument[index]['accessType']}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${readingHistory.readingHistoryDocument[index]['nPages']}',
                                      ),
                                    ],
                                  ),
                                );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1.3,
                          );
                        },
                        itemCount:
                            readingHistory.readingHistoryDocument.length),
                    itemCount: readingHistory.readingHistoryDocument.length,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TrendinCard(
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            title: Text('Linial Warhead'),
                            subtitle: Text('Musa Damu'),
                            trailing: Text('12-03-2020'),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1.3,
                          );
                        },
                        itemCount: 10),
                    itemCount: 1,
                  ),
                  SizedBox(height: 15.0),
                  SuggestionCard(
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(),
                            title: Text('Axial Warhead'),
                            subtitle: Text('Musa Damu'),
                            trailing: Text('12-03-2020'),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 1.3,
                          );
                        },
                        itemCount: 10),
                    itemCount: 10,
                  ),
                  Analytics(chartWidget: chartWidget),
                  QueueManagerContainer(
                    queueTitle: 'Document Conversion Queue',
                    activeQueue: 14,
                    waitingQueue: 10,
                    completedQueue: 2,
                    failedQueue: 0,
                  ),
                  SizedBox(height: 15),
                  QueueManagerContainer(
                    queueTitle: 'OCR Queue',
                    activeQueue: 14,
                    waitingQueue: 10,
                    completedQueue: 2,
                    failedQueue: 0,
                  ),
                  SizedBox(height: 15),
                  QueueManagerContainer(
                    queueTitle: 'Research Upload Queue',
                    activeQueue: 14,
                    waitingQueue: 10,
                    completedQueue: 2,
                    failedQueue: 0,
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
        label: Text('Upload Research'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class QueueManagerContainer extends StatelessWidget {
  const QueueManagerContainer({
    Key key,
    this.queueTitle,
    this.activeQueue = 0,
    this.completedQueue = 0,
    this.waitingQueue = 0,
    this.failedQueue = 0,
  }) : super(key: key);
  final String queueTitle;
  final int activeQueue, completedQueue, waitingQueue, failedQueue;
  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      child: Column(
        children: [
          Text(
            queueTitle ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(thickness: 0.9),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 0.3,
                          color: Color(0xff00a368),
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.rocket,
                        color: Color(0xff00a368),
                      ),
                    ),
                    title: Text('Active'),
                    subtitle: Text(activeQueue.toString() ?? 0),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 0.3,
                          color: Color(0xffd54b02),
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.history,
                        color: Color(0xffd54b02),
                      ),
                    ),
                    title: Text('Waiting'),
                    subtitle: Text(waitingQueue.toString() ?? 0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 0.3,
                          color: Color(0xff221173),
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Color(0xff221173),
                      ),
                    ),
                    title: Text('Completed'),
                    subtitle: Text(completedQueue.toString() ?? 0),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 0.3,
                          color: Color(0xffc10a00),
                        ),
                      ),
                      child: Icon(
                        Icons.warning,
                        color: Color(0xffc10a00),
                      ),
                    ),
                    title: Text('Failed'),
                    subtitle: Text(failedQueue.toString() ?? 0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
