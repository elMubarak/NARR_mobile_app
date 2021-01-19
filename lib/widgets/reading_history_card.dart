import 'package:flutter/material.dart';
import 'package:narr/screens/history.dart';
import 'package:narr/widgets/container_card.dart';

class ReadingHistoryCard extends StatelessWidget {
  const ReadingHistoryCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reading History',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(History.id);
                },
                child: Text(
                  'View More..',
                ),
              ),
            ],
          ),
          Divider(thickness: 1.2),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
