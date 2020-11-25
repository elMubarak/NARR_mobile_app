import 'package:flutter/material.dart';
import 'package:narr/screens/reader.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class ResearchWork extends StatelessWidget {
  final researchId;
  ResearchWork({this.researchId});
  @override
  Widget build(BuildContext context) {
    String publicUrl = 'http://192.168.88.41:4000/repository';
    String myUrl = 'http://192.168.43.219:4000/repository';
    return Scaffold(
      body: FutureBuilder(
        future: NetworkHelper(url: myUrl).getSingleResearch(researchId),
        builder: (context, research) {
          if (!research.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return DefaultTabController(
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
                          '${research.data['payload']['title']}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      background: Image.network(
                        '${research.data['payload']['image']}',
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: Text(
                                    '${research.data['payload']['author']}',
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
                                      'Date Published: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${research.data['payload']['date']}',
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${research.data['payload']['pages']}',
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
                                      'Description: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${research.data['payload']['content']}',
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
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Reader();
                                    }));
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
