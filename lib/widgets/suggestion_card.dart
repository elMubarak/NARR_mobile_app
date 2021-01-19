import 'package:flutter/material.dart';
import 'package:narr/widgets/container_card.dart';

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suggestions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(thickness: 1.2),
        ],
      ),
    );
  }
}
