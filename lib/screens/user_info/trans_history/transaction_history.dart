import 'package:flutter/material.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key key}) : super(key: key);

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: ContainerWithShadow(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('History '),
                Divider(thickness: 2),
                ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final int count = index + 1;
                      return ListTile(
                        leading: Text(count.toString()),
                        title: Text(
                          'Purchased Axial History',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text('12/12/2019'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '- NGR 0.005',
                              style: TextStyle(
                                color: Colors.green[500],
                              ),
                            ),
                            Text(
                              'Successful',
                              style: TextStyle(
                                color: Colors.green[500],
                              ),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
