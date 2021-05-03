import 'package:flutter/material.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/widgets/container_card.dart';
import 'package:narr/widgets/menu_drawer.dart';
import 'package:narr/widgets/school_dash_card.dart';

class InvestorDashboard extends StatefulWidget {
  static const String id = 'InvestorDashboard';
  @override
  _InvestorDashboardState createState() => _InvestorDashboardState();
}

class _InvestorDashboardState extends State<InvestorDashboard> {
  @override
  Widget build(BuildContext context) {
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
