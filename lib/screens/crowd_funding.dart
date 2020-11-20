import 'package:flutter/material.dart';
import 'package:narr/widgets/crowd_funding_card.dart';

class CrowdFunding extends StatefulWidget {
  static String id = '/CrowdFunding';
  @override
  _CrowdFundingState createState() => _CrowdFundingState();
}

class _CrowdFundingState extends State<CrowdFunding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crowd Funding',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 15),
              child: Text(
                'Fund a Research',
                style: TextStyle(fontSize: 22, color: Colors.grey),
              ),
            ),
            CrowdFundingCard(
              researchTitle: 'Support SVM & Regression Research',
              researchContent:
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt molestias nostrum ab dolorem saepe daple funto!',
              onTap: () {},
            ),
            CrowdFundingCard(
              researchTitle: 'Support SVM & Regression Research',
              researchContent:
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt molestias nostrum ab dolorem saepe daple funto!',
              onTap: () {},
            ),
            CrowdFundingCard(
              researchTitle: 'Support SVM & Regression Research',
              researchContent:
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt molestias nostrum ab dolorem saepe daple funto!',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
