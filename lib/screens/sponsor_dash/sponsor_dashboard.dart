import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/screens/email_client/email_list.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/user_info/profile.dart';
import 'package:narr/widgets/cards.dart';
import 'package:narr/widgets/chart_info.dart';
import 'package:narr/widgets/container_card.dart';
import 'package:narr/widgets/menu_drawer.dart';
import 'package:narr/widgets/school_dash_card.dart';
import 'package:narr/widgets/users_online_card.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SponsorDashboard extends StatefulWidget {
  static const String id = 'SponsorDashboard';
  @override
  _SponsorDashboardState createState() => _SponsorDashboardState();
}

class _SponsorDashboardState extends State<SponsorDashboard> {
  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear('22', 42, Colors.red),
      ClicksPerYear('52', 52, Colors.yellow),
      ClicksPerYear('75', 80, Color(0xff00a368)),
      ClicksPerYear('34', 32, Colors.blue),
      // ClicksPerYear('$_counter', _counter, Colors.green),
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
    var chartWidget2 = Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 100.0,
        child: chart2,
      ),
    );
    return Scaffold(
      drawer: Drawer(
        child: DrawerItems(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: determinePrimaryColor(context),
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
                color: determinePrimaryColor(context),
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
                  //
                  SchoolDashCard(
                    institutionLogo:
                        'https://zenprospect-production.s3.amazonaws.com/uploads/pictures/5eda650bfbfd210001258bb3/picture',
                    institutionName: 'Tetiary Educational Fund',
                    institutionAcronym: 'TETFUND',
                    institutionType: currentUser.institution.type,
                    onTap: () {},
                    year: '',
                    url: '',
                    ownership: '',
                  ),
                  // SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(height: 15),
            FutureBuilder(
              future: getStoredUserObject(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Observer(builder: (_) {
                  return UsersOnlineCard(
                    usersOnline: onlineUsers.numberOfUsersOnline.length,
                    userName: currentUser.userName,
                    userEmail: currentUser.email,
                    onTap: () {
                      Navigator.of(context).pushNamed(Profile.id);
                    },
                  );
                });
              },
            ),
            //
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ContainerCard(
                child: Column(
                  children: [
                    Text('Institution enrolled'),
                    Divider(thickness: 1.2),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderCard(
                          title: 'Universities',
                          count: '10',
                          color: Color(0xff00a368),
                          icon: Icons.school_outlined,
                          onTap: () {},
                          info: '',
                        ),
                        HeaderCard(
                          title: 'Polytechnics',
                          count: '12',
                          color: Colors.red,
                          icon: Icons.school_outlined,
                          onTap: () {},
                          info: '',
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeaderCard(
                          title: 'college of education',
                          // info: 'Mentions in the last 1 year',
                          count: '22',
                          color: Colors.orange,
                          icon: Icons.school_outlined, info: '', onTap: () {},
                        ),
                        // HeaderCard(
                        //   title: 'Research Grants',
                        //   count: '22',
                        //   color: Colors.red,
                        //   icon: Icons.insert_drive_file,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ContainerCard(
                child: Column(
                  children: [
                    Text('Online'),
                    Divider(thickness: 1.2),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoleOnlineCard(
                          title: 'Researchers online',
                          count: '22',
                          color: Color(0xff00a368),
                          icon: Icons.people,
                        ),
                        RoleOnlineCard(
                          title: 'Admins online',
                          count: '2',
                          color: Colors.lightBlue,
                          icon: Icons.person,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoleOnlineCard(
                          title: 'Investors online',
                          count: '22',
                          color: Colors.yellow,
                          icon: Icons.attach_money,
                        ),
                        RoleOnlineCard(
                          title: 'Sponsors online',
                          count: '22',
                          color: Colors.red,
                          icon: Icons.money_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Analytics(
              title: 'Total research uploaded by institution',
              chartWidget: chartWidget,
              child: Container(),
            ),
            SizedBox(height: 15),
            Analytics(
              title: 'Categories chart by institution',
              chartWidget: chartWidget2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChartInfoG(
                    color: Colors.red,
                    info: 'Arts',
                  ),
                  ChartInfoG(
                    color: Colors.yellow,
                    info: 'Social Sciences',
                  ),
                  ChartInfoG(
                    color: Colors.green,
                    info: 'Science',
                  ),
                  ChartInfoG(
                    color: Colors.blue,
                    info: 'Education',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Color(0xff00a368),
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(SingleFileUpload.id);
      //   },
      //   label: Text('Upload Research'),
      //   icon: Icon(Icons.add),
      // ),
    );
  }
}

class RoleOnlineCard extends StatelessWidget {
  const RoleOnlineCard({
    required this.title,
    required this.color,
    required this.count,
    required this.icon,
  });
  final String title;
  final Color color;
  final String count;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          CircleAvatar(
            radius: 18,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 13,
              // color: color,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
