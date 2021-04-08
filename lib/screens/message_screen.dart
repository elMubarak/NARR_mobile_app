import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final messages;
  final String name;
  MessageScreen({this.messages, @required this.name});
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // MessagesStream(),

            MessageBubble(
              text: "Hello",
              isMe: true,
            ),
            MessageBubble(
              text: "hi",
              isMe: false,
            ),
            MessageBubble(
              text: "How are you",
              isMe: true,
            ),
            MessageBubble(
              text: "Am good and you",
              isMe: false,
            ),
            MessageBubble(
              text: "coool",
              isMe: true,
            ),
            MessageBubble(
              text: "How sweet flutter is?",
              isMe: false,
            ),
            MessageBubble(
              text: "Its one of the best tool for mobile development",
              isMe: true,
            ),
            MessageBubble(
              text: "Wow am goonna try it someday",
              isMe: false,
            ),
            MessageBubble(
              text: "Am sure you gonna like it 😊",
              isMe: true,
            ),
            MessageBubble(
              text: "Alright then",
              isMe: false,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        prefixIcon: Icon(
                          Icons.emoji_emotions,
                        ),
                        suffixIcon: Icon(Icons.send),
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          // borderSide: BorderSide.none,
                          //borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.isMe});

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Color(0xff00a368) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MaterialButton(
//                   color: Color(0xff00a368),
//                   shape: CircleBorder(),
//                   onPressed: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Icon(
//                       Icons.send,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
