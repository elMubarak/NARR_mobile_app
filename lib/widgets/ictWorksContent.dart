import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:narr/services/url_luncher.dart';

class IctWorksContent extends StatelessWidget {
  const IctWorksContent(
      {Key? key,
      required this.content,
      required this.title,
      required this.creator,
      required this.imgUrl,
      required this.categories,
      required this.linkUrl,
      required this.date})
      : super(key: key);

  final String content, title, creator, imgUrl, linkUrl, date;
  final categories;

  @override
  Widget build(BuildContext context) {
    List _items = categories;
    final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                '$title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Image.network(
          "$imgUrl",
          height: 170,
        ),
        SizedBox(
          height: 10,
        ),
        Html(
          data: content,
        ),
        SizedBox(
          height: 10,
        ),
        // Html(
        //   data: ,
        // ),
        SizedBox(
          height: 10,
        ),
        Tags(
          key: _tagStateKey,
          itemCount: _items.length, // required
          itemBuilder: (int index) {
            final item = _items[index];

            return ItemTags(
              // Each ItemTags must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(index.toString()),
              index: index, // required
              title: item,
              textStyle: TextStyle(
                fontSize: 15,
              ),
              activeColor: Color(0xff00a368),
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RaisedButton(
              onPressed: () => launchURL(linkUrl),
              child: Text(
                'Link',
                style: TextStyle(color: Colors.white),
              ),
              color: Color(0xff00a368),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.grey[600],
            ),
            Text(
              'Creator:',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              '$creator',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.grey[600],
            ),
            Text(
              'Date:',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              '$date',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
