import 'package:flutter/material.dart';

class History extends StatefulWidget {
  static const String id = 'History';
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NARR'),
        backgroundColor: Color(0xff00a368),
      ),
      body: ListView.separated(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.insert_drive_file),
              radius: 18,
            ),
            title: Text(topics[index]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LinearProgressIndicator(
                  value: 0.6,
                ),
                SizedBox(height: 5),
                Text('12/08/2020')
              ],
            ),
            trailing: Text('Continue'),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}

final List topics = [
  'ACCOUNTING',
  'BANKING AND FINANCE',
  'CATERING MANAGEMENT',
  'DISASTER AND RISK MANAGMENT',
  'ENVIRONMENTAL SCIENCE',
  'FISHERY AND AQUACULTURE',
  ' GUIDANCE COUNSELING',
];
