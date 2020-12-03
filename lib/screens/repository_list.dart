import 'package:flutter/material.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/screens/single_research_repository.dart';
import 'package:narr/services/backend_service.dart';

class RepositoryList extends StatefulWidget {
  static String id = '/repository list';
  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  String researchRepoUrl = 'https://narr.ng/api/v1/research';
  void initState() {
    super.initState();
    setState(() {
      NetworkHelper(url: 'https://narr.ng/api/v1/research').getAllResearch();
    });
  }

  DropdownHelper _dropdownHelper = DropdownHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repository'),
      ),
      body: FutureBuilder(
        future: NetworkHelper(url: researchRepoUrl).getAllResearch(),
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
              padding: const EdgeInsets.only(left: 15.0, right: 160),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(0, 2.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'By Category',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  items: _dropdownHelper.getFilterDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _dropdownHelper.selectedFilter = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 11,
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
            var title = document['researchTitle'];
            List author = document['authors'];
            var year = document['year'];
            var image = document['thumbnail'];
            var pages = document['nPages'];
            String id = document['_id'];
            final courseTitleWidget = ResearchRepositoryCard(
              imageUrl: 'https://narr.ng$image',
              researchTitle: title,
              researchAuthor: author,
              researchDate: year,
              pages: pages,
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
    this.pages,
    this.onTap,
  }) : super(key: key);
  final String researchTitle, researchDate, imageUrl;
  final int pages;
  final List researchAuthor;
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1b5e20),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date Published: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1b5e20),
                            ),
                          ),
                          Text(
                            '$researchDate',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Authors: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1b5e20),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '$researchAuthor',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Pages: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1b5e20),
                            ),
                          ),
                          Text(
                            '$pages',
                            overflow: TextOverflow.ellipsis,
                          ),
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
