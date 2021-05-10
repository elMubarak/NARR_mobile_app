import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/screens/email_client/email_list.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/profile.dart';
import 'package:narr/widgets/cards.dart';
import 'package:narr/widgets/container_card.dart';
import 'package:narr/widgets/menu_drawer.dart';
import 'package:narr/widgets/school_dash_card.dart';
import 'package:narr/widgets/users_online_card.dart';

class AdminDashBoard extends StatelessWidget {
  static const String id = 'AdminDashBoard';
  @override
  Widget build(BuildContext context) {
    determinePrimaryColor(context);
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                children: [
                  SizedBox(height: 15.0),

                  // Analytics(chartWidget: chartWidget),
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
