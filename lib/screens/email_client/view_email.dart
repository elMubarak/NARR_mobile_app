import 'package:flutter/material.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/models/email_model.dart';

class ViewEmail extends StatelessWidget {
  final EmailsModel email;

  const ViewEmail(this.email);
  @override
  Widget build(BuildContext context) {
    // bool hasImage = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: determinePrimaryColor(context),
        elevation: 0,
        centerTitle: true,
        title: Text(
          email.subject,
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
          child: Column(
            children: [
              Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: CircleAvatar(),
                title: Text(
                  email.from,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('to: Me',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    )),
                trailing: Text('12 30',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(80),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    email.body,
                    style: TextStyle(fontSize: 21),
                  ),
                  SizedBox(height: 100),
                  Attachment(color: Colors.green),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.7,
                ),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    IconTitle(
                      title: 'Reply',
                      icon: Icons.repeat,
                    ),
                    SizedBox(width: 15),
                    IconTitle(
                      title: 'Foward',
                      icon: Icons.forward,
                    ),
                  ]),
                  Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconTitle extends StatelessWidget {
  const IconTitle({
    Key key,
    this.icon,
    this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}

class Attachment extends StatelessWidget {
  const Attachment({
    Key key,
    this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ATTACHMENT'),
          // SizedBox(height: 5),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('PDF')),
            ),
            title: Text('Rsearch Document'),
            subtitle: Text('22.65MB'),
          ),
        ],
      ),
    );
  }
}
