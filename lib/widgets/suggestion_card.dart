import 'package:flutter/material.dart';

class SugesstionCardContent extends StatelessWidget {
  const SugesstionCardContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(
          Icons.insert_drive_file,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      title: Text('A research on neurral network...'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'While i was researching on the case the criminals hair was...',
          ),
          SizedBox(height: 5),
          Text('12/08/2020')
        ],
      ),
    );
  }
}
