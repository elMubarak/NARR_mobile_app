import 'package:flutter/material.dart';
import 'package:narr/widgets/container_card.dart';

class UsersOnlineCard extends StatelessWidget {
  const UsersOnlineCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ContainerCard(
        child: Column(
          children: [
            Text('User\'s Online: 12'),
            Divider(thickness: 1.2),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xffd3d4cf),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_outline,
                color: Color(0xff00a368).withOpacity(0.5),
              ),
            ),
            SizedBox(height: 15),
            Text('User'),
          ],
        ),
      ),
    );
  }
}
