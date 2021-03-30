import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:narr/screens/message_screen.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future readChats() async {
    final String response = await rootBundle.loadString('assets/chat.json');
    final data = await json.decode(response);
    // print(data);
    return data;
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: FutureBuilder(
        future: readChats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var chat = snapshot.data[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('${chat['profile']}'),
                ),
                title: Text('${chat['name']}'),
                subtitle: Text('${chat['lastMessage']}'),
                trailing: Text(
                  '${chat['time']}',
                  style: TextStyle(
                    color: Color(0xff00a368),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MessageScreen(
                          name: chat['name'],
                          messages: chat['messages'],
                        );
                      },
                    ),
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: snapshot.data.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: null,
      ),
    );
  }
}
