import 'package:flutter/material.dart';
import 'package:narr/widgets/search_filter.dart';

class BottomSheet extends StatelessWidget {
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
