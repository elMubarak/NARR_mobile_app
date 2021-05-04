import 'package:flutter/material.dart';
import 'package:narr/global/global_vars.dart';

class ComposeEmail extends StatefulWidget {
  @override
  _ComposeEmailState createState() => _ComposeEmailState();
}

class _ComposeEmailState extends State<ComposeEmail> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    focusNode.requestFocus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: determinePrimaryColor(context),
        title: Text(
          'Compose',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('From'),
                  SizedBox(width: 15),
                  DropdownButton(
                    items: [],
                    hint: Text('Musadams@gmail.com'),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('To'),
                  SizedBox(width: 15),
                  Expanded(
                      child: TextField(
                    focusNode: focusNode,
                  )),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Subject'),
                  SizedBox(width: 15),
                  Expanded(child: TextField()),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Compose Email'),
                  SizedBox(width: 15),
                  Expanded(
                      child: TextField(
                    maxLines: 5,
                    minLines: 2,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
