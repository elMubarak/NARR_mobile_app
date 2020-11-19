import 'package:flutter/material.dart';

String networkImageUri =
    'https://miro.medium.com/max/1146/1*KhUes1b3TtkStUXseSseEA.png';

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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 15),
              child: Text(
                'Fund a Research',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            CrowdFundingCouresCard(
              researchTitle: 'Support SVM & Regression Research',
              researchContent:
                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt molestias nostrum ab dolorem saepe alias voluptatum recusandae nemo ratione esse!',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CrowdFundingCouresCard extends StatelessWidget {
  const CrowdFundingCouresCard({
    Key key,
    this.researchTitle,
    this.researchContent,
    this.onTap,
  }) : super(key: key);
  final String researchTitle, researchContent;

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 2.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      topLeft: Radius.circular(6),
                    ),
                    child: Image.network(
                      '$networkImageUri',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$researchTitle',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$researchContent',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff00a368),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'START COURSE',
                              style: TextStyle(
                                color: Color(0xff00a368),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
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
