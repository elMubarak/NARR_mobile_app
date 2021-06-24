import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narr/screens/user_info/wallet/bank_info/bank_info_tab.dart';
import 'package:narr/screens/user_info/wallet/wallet_info/wallet_tab.dart';

class PaymentInfoScreen extends StatefulWidget {
  const PaymentInfoScreen({Key key}) : super(key: key);

  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(' Bank| Wallet'),
          actions: [
            IconButton(
                tooltip: 'Transaction history',
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.history,
                )),
            SizedBox(width: 15)
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text('Blockchain wallet details'),
                  ),
                  Tab(
                    child: Text('Bank details'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            WalletTab(),
            BankInfoTab(),
          ],
        ),
      ),
    );
  }
}
