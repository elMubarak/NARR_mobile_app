import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:narr/configs.dart';
import 'package:narr/screens/reader.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/store/hive_store.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class ResearchWork extends StatelessWidget {
  final String researchId;
  ResearchWork({required this.researchId});

  @override
  Widget build(BuildContext context) {
    Uri singleResearchUrl = Uri.parse('$serverUrl/research');
    HiveBox _box = HiveBox();
    bool _isVertical = false;
    IconData _selectedIcon;

    var token;
    getToken() async {
      String savedToken = await _box.getSavedToken();
      token = savedToken;
    }

    getToken();
    return FutureBuilder<dynamic>(
      future: NetworkHelper(url: singleResearchUrl)
          .getSingleResearch(researchId, singleResearchUrl.toString()),
      builder: (context, research) {
        if (!research.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(research.data['research']['researchTitle']),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ContainerWithShadow(
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
                                  'https://api.narr.ng${research.data['research']['thumbnail']}?action=thumbnail&token=$token',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(
                          color: Color(0xff00a368),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Authors: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                '${research.data['research']['authors'].toString().replaceAll('[', '').replaceAll(']', '')}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 8,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Year: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: Text(
                                    '${research.data['research']['year']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Category: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: Text(
                                    '${research.data['research']['category']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pages: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: Text(
                                    '${research.data['research']['nPages']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Access Type: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: Text(
                                    '${research.data['research']['accessType']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            research.data['accessType'] == 'Free'
                                ? Container()
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Monthly Fee: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${research.data['research']['monthlyFee']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 8,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReadButton(
                                  title: 'Read',
                                  id: research.data['research']['_id'],
                                ),
                                ReadButton(
                                  title: 'Bookmark',
                                  id: research.data['research']['_id'],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ContainerWithShadow(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff00a368),
                          ),
                        ),
                        Divider(
                          color: Colors.green,
                        ),
                        SizedBox(height: 15),
                        Text(
                          '${research.data['research']['description']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ContainerWithShadow(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Analytics',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff00a368),
                            ),
                          ),
                          Divider(color: Colors.green),
                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.import_contacts,
                                size: 17,
                                color: Color(0xff00a368),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Hits: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                child: Text(
                                  '${research.data['research']['hits']}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 8,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.import_contacts,
                                size: 17,
                                color: Color(0xff00a368),
                              ),
                              Text(
                                'Currently Reading: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                child: Text(
                                  '330',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 8,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.book,
                                size: 17,
                                color: Color(0xff00a368),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Read By: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                child: Text(
                                  '350',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 8,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.thumb_up,
                                size: 17,
                                color: Color(0xff00a368),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Liked By: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                child: Text(
                                  '350',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 8,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                size: 17,
                                color: Color(0xff00a368),
                              ),
                              SizedBox(width: 5),

                              Text(
                                'Rating: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // ignore: missing_required_param
                              RatingBar.builder(
                                initialRating: 4.5,
                                minRating: 0,
                                direction: _isVertical
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                allowHalfRating: true,
                                unratedColor: Colors.amber.withAlpha(50),
                                itemCount: 5,
                                itemSize: 20.0,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (double value) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReadButton extends StatelessWidget {
  const ReadButton({required this.id, required this.title});
  final String id, title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Reader(id);
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff00a368),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xff00a368),
          ),
        ),
      ),
    );
  }
}

// contact.data[0]['phone']
