import 'package:flutter/material.dart';

class RepositoryList extends StatefulWidget {
  static String id = '/repository list';
  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repository'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(50),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Repository',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 11,
                      top: 11,
                      right: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 15),
              child: Text(
                'All Research',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            ResearchRepositoryCard(
              researchTitle: 'Data Science For beginners',
              researchAuthor: 'Mubarak na Mairo',
              researchDate: '11-02-2020',
              onTap: () {},
            ),
            ResearchRepositoryCard(
              researchTitle: 'Data Science For beginners',
              researchAuthor: 'Mubarak na Mairo',
              researchDate: '11-02-2020',
              onTap: () {},
            ),
            ResearchRepositoryCard(
              researchTitle: 'Data Science For beginners',
              researchAuthor: 'Mubarak na Mairo',
              researchDate: '11-02-2020',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ResearchRepositoryCard extends StatelessWidget {
  const ResearchRepositoryCard({
    Key key,
    this.researchTitle,
    this.researchCategory,
    this.researchDate,
    this.researchAuthor,
    this.onTap,
  }) : super(key: key);
  final String researchTitle, researchCategory, researchDate, researchAuthor;
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
                      'https://i1.wp.com/thedatascientist.com/wp-content/uploads/2019/06/what-is-data-science.jpg?resize=1024%2C576&ssl=1',
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date Published: $researchDate',
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Author: $researchAuthor',
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
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
