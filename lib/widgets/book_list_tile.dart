import 'package:flutter/material.dart';

class BookListTile extends StatelessWidget {
  const BookListTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/proxy/BxKjEydXx5wO6dpCywJcBqXL6VNTh9K69kKRHvSrOcfX1jhNBvt1gHQyn6fr9jqVaeJtIjptDw0Acs9iaFsd-TadY8DOuJLcH0hC88D7vdOmf54yY0fO17BdkToNA-TzIECD4NnzFaX8y7t7h-Y5TWyasjU3EEhBcyQWl1WMw0Kr1lbw8a55UymzGUKHkiQ'),
            ),
            title: Text('SCM Research Analysis'),
            subtitle: Text('Documented Reserch 500 Pages'),
            trailing: Text(
              '₦100',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          Divider(
            height: 10,
          ),
        ],
      ),
    );
  }
}
