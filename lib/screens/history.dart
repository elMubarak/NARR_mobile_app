import 'package:flutter/material.dart';
import 'package:narr/provider/app_data.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  static const String id = 'History';
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    List readingHistory = Provider.of<AppData>(context, listen: false)
        .analyticObj['readingHistory'];
    return Scaffold(
      appBar: AppBar(
        title: Text('NARR'),
        backgroundColor: Color(0xff00a368),
      ),
      body: ListView.separated(
        itemCount: readingHistory.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              child: Icon(Icons.insert_drive_file),
            ),
            title: Text(
              '${readingHistory[index]['researchTitle']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${readingHistory[index]['authors'].toString().replaceAll('[', '').replaceAll(']', '')}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${readingHistory[index]['accessType']},'),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${readingHistory[index]['nPages']}',
                  style: TextStyle(
                    color: Color(0xff00a368),
                  ),
                ),
              ],
            ),
          );
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
