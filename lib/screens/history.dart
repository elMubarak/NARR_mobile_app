import 'package:flutter/material.dart';

class History extends StatefulWidget {
  static const String id = 'History';
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final List topics = [
    'ACCOUNTING',
    'BANKING AND FINANCE',
    'CATERING MANAGEMENT',
    'DISASTER AND RISK MANAGMENT',
    'ENVIRONMENTAL SCIENCE',
    'FISHERY AND AQUACULTURE',
    ' GUIDANCE COUNSELING',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NARR'),
        backgroundColor: Colors.green[500],
      ),
      body: ListView.separated(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics[index]),
            trailing: Text('12/08/2020'),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
