import 'package:flutter/material.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/single_research_repository.dart';

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
        title: Text('Reading History'),
        backgroundColor: Color(0xff00a368),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: ListView.separated(
          itemCount: readingHistory.readingHistoryDocument.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
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
              subtitle: Column(
                children: [
                  Text(
                    '${readingHistory.readingHistoryDocument[index]['authors'].toString().replaceAll('[', '').replaceAll(']', '')}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: readingHistory.readingHistoryDocument[index]
                            ['percentCompleted'] /
                        100,
                  ),
                ],
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
                      researchId: readingHistory.readingHistoryDocument[index]
                          ['_id'],
                    ),
                  ),
                );
              },
            );
          },
        ),
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
