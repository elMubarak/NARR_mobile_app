import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/screens/reader.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/store/hive_store.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class ResearchWork extends StatelessWidget {
  final String researchId;
  ResearchWork({this.researchId});

  @override
  Widget build(BuildContext context) {
    String singleResearchUrl = '$serverUrl/research';
    HiveBox _box = HiveBox();

    var token;
    getToken() async {
      String savedToken = await _box.getUser('token');
      token = savedToken;
    }

    getToken();
    return Scaffold(
      body: FutureBuilder(
        future:
            NetworkHelper(url: singleResearchUrl).getSingleResearch(researchId),
        builder: (context, research) {
          if (!research.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Color(0xff00a368),
                      automaticallyImplyLeading: true,
                      elevation: 0,
                      expandedHeight: 150.0,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Padding(
                          padding: const EdgeInsets.only(left: 45, right: 20.0),
                          child: Text(
                            '${research.data['payload']['researchTitle']}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        background: Image.network(
                          "https://api.narr.ng${research.data['payload']['thumbnail']}?action=thumbnail&token=$token",
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.dstATop,
                          color: innerBoxIsScrolled
                              ? Colors.red
                              : Colors.black.withOpacity(0.6),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loading) {
                            if (loading == null) return child;

                            return Center(
                              child: CircularProgressIndicator(
                                value: loading.expectedTotalBytes != null
                                    ? loading.cumulativeBytesLoaded /
                                        loading.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  child: Column(
                    children: [
                      ContainerWithShadow(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Authors: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${research.data['payload']['authors'].toString().replaceAll('[', '').replaceAll(']', '')}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date Published: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${research.data['payload']['year']}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Category: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${research.data['payload']['category']}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pages: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${research.data['payload']['nPages']}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Access Type: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${research.data['payload']['accessType']}',
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
                                  research.data['payload']['accessType'] ==
                                          'Free'
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
                                                '${research.data['payload']['monthlyFee']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 8,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Description: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${research.data['payload']['description']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 8,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            print(research.data['payload']
                                                ['_id']);
                                            return Reader(research
                                                .data['payload']['_id']);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xff00a368),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'READ',
                                        style: TextStyle(
                                          color: Color(0xff00a368),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: unused_element
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.breadcrumnb);

  final Widget breadcrumnb;

  @override
  double get minExtent => 40;
  @override
  double get maxExtent => 40;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: breadcrumnb,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// contact.data[0]['phone']
