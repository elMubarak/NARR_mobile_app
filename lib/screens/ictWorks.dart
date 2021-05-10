import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:narr/configs.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/grants_outlined_container.dart';
import 'package:narr/widgets/ictWorksContent.dart';

class IctWorks extends StatefulWidget {
  static String id = '/ictWorks';
  @override
  _IctWorksState createState() => _IctWorksState();
}

class _IctWorksState extends State<IctWorks> {
  bool buttonPressed = false;
  Future readJson() async {
    final String response = await rootBundle.loadString('assets/feed.json');
    final data = await json.decode(response);
    return data;
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICT Works'),
      ),
      body: GrantsOutlinedContainer(
        child: FutureBuilder(
          future: NetworkHelper(url: '$serverUrl/ictWorks').getAllIctWorks(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print('${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No Data');
            } else if (snapshot.hasData) {
              print(data);
              return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  var tag =
                      data[index]['contentEncoded'].replaceAll('<h3>', '<p>');
                  var content = tag.split('<p>')[1];
                  var result = content.split('src=')[1];
                  var img = result.split('"')[1];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: IctWorksContent(
                          content: data[index]['contentEncodedSnippet'] ?? "",
                          title: data[index]['title'] ?? "",
                          creator: data[index]['creator'] ?? "",
                          imgUrl: img ?? '',
                          categories: data[index]['categories'] ?? "",
                          linkUrl: data[index]['link'] ?? "",
                          date: data[index]['isoDate'],
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return Text('No Data');
            }
            return Text('${snapshot.error}');
          },
        ),
      ),
    );
  }
}
//  var data =
//                     snapshot.data[index]['content:encoded'].split('<p>')[1];
//                 var result = data.split('src=')[1];
//                 if (result == null) {
//                   snapshot.data[index].imgSrc =
//                       'https://i.stack.imgur.com/y9DpT.jpg';
//                 } else {
//                   var img = result.split('"')[1];
//                   snapshot.data[index].imgSrc
//                 }
// Padding(
//                 padding: const EdgeInsets.only(
//                     top: 8.0, bottom: 8.0, right: 8.0, left: 15),
//                 child: Text(
//                   'Research Grants Feed',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
//                 ),
//               ),
//               Divider(
//                 thickness: 1.0,
//               ),
