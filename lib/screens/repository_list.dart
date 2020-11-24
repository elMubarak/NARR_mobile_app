import 'package:flutter/material.dart';
import 'package:narr/screens/single_research_repository.dart';
import 'package:narr/services/backend_service.dart';

class RepositoryList extends StatefulWidget {
  static String id = '/repository list';
  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  String myUrl = 'http://192.168.88.41:4000/repository';
  String publicUrl = 'http://192.168.43.219:4000/repository';
  void initState() {
    super.initState();
    setState(() {
      NetworkHelper(url: 'http://192.168.88.41:4000/repository')
          .getAllResearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repository'),
      ),
      body: FutureBuilder(
        future: NetworkHelper(url: myUrl).getAllResearch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final payload = snapshot.data;
          List<Widget> contactTitleWidgets = [
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 15),
              child: Text(
                'All Research',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          ];
          for (var document in payload) {
            var title = document['title'];
            var author = document['author'];
            var date = document['date'];
            var image = document['image'];
            var id = document['id'];
            final courseTitleWidget = ResearchRepositoryCard(
              imageUrl: image,
              researchTitle: title,
              researchAuthor: author,
              researchDate: date,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ResearchWork(
                        researchId: id,
                      );
                    },
                  ),
                );
              },
            );
            contactTitleWidgets.add(courseTitleWidget);
          }
          return ListView(
            children: contactTitleWidgets,
          );
        },
      ),
    );
  }
}

class ResearchRepositoryCard extends StatelessWidget {
  const ResearchRepositoryCard({
    Key key,
    this.imageUrl,
    this.researchTitle,
    this.researchDate,
    this.researchAuthor,
    this.onTap,
  }) : super(key: key);
  final String researchTitle, researchDate, researchAuthor, imageUrl;
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
                      imageUrl,
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
