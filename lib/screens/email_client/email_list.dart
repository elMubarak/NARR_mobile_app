import 'package:flutter/material.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/screens/email_client/view_email.dart';

import 'compose_email.dart';

class EmailList extends StatefulWidget {
  static const String id = 'EmailList';
  @override
  _EmailListState createState() => _EmailListState();
}

class _EmailListState extends State<EmailList> {
  @override
  Widget build(BuildContext context) {
    determinePrimaryColor(context);
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          height: 10,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15),
                height: 100,
                color: determinePrimaryColor(context),
                child: Center(
                  child: Text(
                    'Email Client',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Inbox'),
                      trailing: Text('20'),
                    ),
                    ListTile(
                      title: Text('Outbox'),
                      trailing: Text('2'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: determinePrimaryColor(context),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          'Email',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListView.builder(
          itemCount: mockEmails.length,
          itemBuilder: (context, index) {
            bool hasImage = mockEmails[index].isImage;
            String iamge = mockEmails[index].senderImage;
            String abrv = mockEmails[index].abrv;

            String icon = hasImage ? iamge : abrv;
            return ListTile(
              contentPadding: EdgeInsets.all(10),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewEmail(mockEmails[index]),
                ));
              },
              leading: (hasImage == true)
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(icon),
                    )
                  : CircleAvatar(
                      child: Text(abrv),
                      backgroundColor: mockEmails[index].color,
                    ),
              title: Text(
                mockEmails[index].sender,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mockEmails[index].title,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    mockEmails[index].message,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: Text(mockEmails[index].dateTime),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: determinePrimaryColor(context),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ComposeEmail(),
            ),
          );
        },
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}

class EmailModel {
  final String sender;
  final String abrv;
  final String dateTime;
  final String senderImage;
  final String title;
  final String message;
  final Color color;
  final bool isImage;

  EmailModel(
    this.isImage, {
    this.abrv,
    this.sender,
    this.dateTime,
    this.senderImage,
    this.title,
    this.message,
    this.color,
  });
}

List<EmailModel> mockEmails = [
  EmailModel(false,
      sender: 'Musa Damu',
      abrv: 'M',
      title: 'The Tetfund primary research',
      message:
          'Hello Sir, this is the verified version of the agreed documents to be used, we are now ready for the next phase',
      dateTime: '12:09 am',
      color: Colors.green),
  EmailModel(false,
      sender: 'Asiya Jibson',
      abrv: 'A',
      title: 'Submition of the grant proposal',
      message:
          'Submition of of the proposal stated for the use in acordance to change in the system, given entropy is vial',
      dateTime: '12:09 am',
      color: Colors.pink),
  EmailModel(true,
      sender: 'Gabriel J. Moses',
      senderImage:
          'https://www.pavilionweb.com/wp-content/uploads/2017/03/user-300x300.png',
      title: 'The Tetfund primary research',
      message:
          'Hello Sir, this is the verified version of the agreed documents to be used, we are now ready for the next phase',
      dateTime: '12:09 am',
      color: Colors.grey),
  EmailModel(false,
      sender: 'Titan Amored',
      abrv: 'T',
      title: 'New Titan Research',
      message:
          'Hello Sir, this is the verified version of the agreed documents to be used, we are now ready for the next phase',
      dateTime: '9:09 pm',
      color: Colors.red),
  EmailModel(true,
      sender: 'Mr. Moses',
      senderImage:
          'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png',
      title: 'The Tetfund primary research',
      message:
          'Hello Sir, this is the verified version of the agreed documents to be used, we are now ready for the next phase',
      dateTime: '4 May',
      color: Colors.grey),
  EmailModel(true,
      sender: 'Zainab Bashir',
      senderImage:
          'https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png',
      title: 'The Tetfund primary research',
      message:
          'Hello Sir, this is the verified version of the agreed documents to be used, we are now ready for the next phase',
      dateTime: '3 May',
      color: Colors.grey),
  EmailModel(false,
      sender: 'Usman  Murtala',
      abrv: 'UM',
      title: 'Github pull request',
      message:
          ' this is the verified version of the agreed documents to be used, we are now ready for the next phase',
      dateTime: '2 May',
      color: Colors.grey),
];
