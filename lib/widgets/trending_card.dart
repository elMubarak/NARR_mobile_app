import 'package:flutter/material.dart';
import 'package:narr/widgets/container_card.dart';

class TrendinCard extends StatelessWidget {
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
        ],
      ),
    );
  }
}
