import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  const Analytics({
    Key key,
    @required this.chartWidget,
    this.title,
    this.child,
  }) : super(key: key);

  final Padding chartWidget;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title ?? ''),
                    Text(
                      '2021',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 1.2),
                SizedBox(height: 10),

                //charts
                chartWidget,
                SizedBox(height: 10),
                child ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChartInfoG(
                          color: Colors.red,
                          info: 'Reading',
                        ),
                        ChartInfoG(
                          color: Colors.yellow,
                          info: 'Mention',
                        ),
                        ChartInfoG(
                          color: Colors.green,
                          info: 'Recomendations',
                        ),
                      ],
                    ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Febuary 6 - May',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontSize: 11),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 13,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ChartInfoG extends StatelessWidget {
  const ChartInfoG({
    Key key,
    this.color,
    this.info,
  }) : super(key: key);
  final Color color;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '$info',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// class Tags extends StatelessWidget {
//   const Tags({
//     Key key,
//     this.tag,
//   }) : super(key: key);
//   final String tag;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(5),
//       margin: EdgeInsets.only(top: 5, bottom: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.grey.withOpacity(0.25),
//       ),
//       child: Text('$tag'),
//     );
//   }
// }
