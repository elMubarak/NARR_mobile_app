import 'package:flutter/material.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
              SizedBox(height: 15),
              Divider(),
              CategoryItem(item: 'History'),
              CategoryItem(item: 'Law'),
              CategoryItem(item: 'Science'),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    this.item,
  }) : super(key: key);
  final String item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          title: Center(
            child: Text('$item'),
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.1),
          height: 1,
        ),
      ],
    );
  }
}
