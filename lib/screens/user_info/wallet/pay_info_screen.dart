import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          // title: Text('Bank|Wallet'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text('Wallet'),
                  ),
                  Tab(
                    child: Text('Bank information'),
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
