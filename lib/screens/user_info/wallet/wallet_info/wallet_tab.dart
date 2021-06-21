import 'package:flutter/material.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class WalletTab extends StatelessWidget {
  const WalletTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerWithShadow(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text('NGR 0.504'),
                  ),
                  SizedBox(height: 10),
                  Text('Token'),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Fund Wallet'),
                      Container(
                        height: 20,
                        child: VerticalDivider(
                          thickness: 2,
                        ),
                      ),
                      Text('Transaction History'),
                      Container(
                        height: 20,
                        child: VerticalDivider(
                          thickness: 2,
                        ),
                      ),
                      Text('Gas Balance'),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
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
          ],
        ),
      ),
    );
  }
}
