import 'package:flutter/material.dart';
import 'package:narr/widgets/container_card.dart';

class TrendinCard extends StatelessWidget {
  TrendinCard({
    Key? key,
    required this.child,
    required this.itemCount,
  }) : super(key: key);
  final Widget child;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    double height = 10;
    if (itemCount == 1) {
      height = 90;
    } else if (itemCount == 2) {
      height = 150;
    } else if (itemCount >= 3) {
      height = 250;
    } else {
      height = 10;
    }
    return ContainerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View More..',
                ),
              ),
            ],
          ),
          Divider(thickness: 1.2),
          SizedBox(height: 15),
          Container(
            height: (itemCount != null) ? height : 10,
            child: (child != null) ? child : Container(),
          )
        ],
      ),
    );
  }
}
