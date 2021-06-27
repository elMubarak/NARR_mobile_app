import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:narr/configs.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/provider/online_users_mobx.dart';
import 'package:narr/provider/reading_history_mobx.dart';
import 'package:narr/screens/email_client/email_list.dart';
import 'package:narr/screens/user_info/profile.dart';
import 'package:narr/screens/single_research_repository.dart';
import 'package:narr/widgets/cards.dart';
import 'package:narr/widgets/chart_info.dart';
import 'package:narr/widgets/container_card.dart';
import 'package:narr/widgets/reading_history_card.dart';
import 'package:narr/widgets/school_dash_card.dart';
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

  List readingHistoryArry = [];

  Widget build(BuildContext context) {
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
    determinePrimaryColor(context);
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
          IconButton(
            padding: EdgeInsets.all(2),
            tooltip: 'Email',
            icon: Icon(
              Icons.email,
            ),
            onPressed: () async {
              Navigator.pushNamed(context, EmailList.id);
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
                    institutionLogo: '$baseUrl${currentUser.institution.logo}',
                    institutionName: currentUser.institution.name,
                    institutionAcronym: currentUser.institution.acronym,
                    institutionType: currentUser.institution.type,
                    year: currentUser.institution.year,
                    ownership: currentUser.institution.ownerShip,
                    url: currentUser.institution.url,
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
                          onTap: () {},
                          info: '',
                        ),
                        HeaderCard(
                          title: 'Read \nSuggestions',
                          count: '22',
                          color: Colors.blue,
                          icon: Icons.import_contacts,
                          info: '',
                          onTap: () {},
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
                          icon: Icons.person,
                          onTap: () {},
                        ),
                        HeaderCard(
                          title: 'Research Grants',
                          count: '22',
                          color: Colors.red,
                          icon: Icons.insert_drive_file,
                          onTap: () {},
                          info: '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<dynamic>(
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
                      itemCount: readingHistory.readingHistoryDocument.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            child: Icon(Icons.insert_drive_file),
                          ),
                          title: Text(
                            '${readingHistory.readingHistoryDocument[index]['researchTitle']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${readingHistory.readingHistoryDocument[index]['authors'].toString().replaceAll('[', '').replaceAll(']', '')}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  '${readingHistory.readingHistoryDocument[index]['accessType']},'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${readingHistory.readingHistoryDocument[index]['nPages']}',
                                style: TextStyle(
                                  color: Color(0xff00a368),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResearchWork(
                                  researchId: readingHistory
                                      .readingHistoryDocument[index]['_id'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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
                  Analytics(
                    chartWidget: chartWidget,
                    title: '',
                    child: Container(),
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
