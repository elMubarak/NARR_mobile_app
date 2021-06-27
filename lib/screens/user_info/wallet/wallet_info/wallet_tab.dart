import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/custom_button.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({
    Key? key,
  }) : super(key: key);

  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  String payStackKey = 'pk_test_b448c10aa89a7654b88480a95b1d787e9f3f61c3';

  TextEditingController fundController = TextEditingController();
  TextEditingController cashout = TextEditingController();
  TextEditingController transferAmount = TextEditingController();
  TextEditingController transferRecipient = TextEditingController();

  String address = 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh';
  @override
  void initState() {
    _initPayStack();
    super.initState();
  }

  void _initPayStack() {
    // PaystackPlugin.initialize(publicKey: publicKey)
    //     .then((PaystackPlugin value) {
    //   print(value);
    // });
  }

  _charge(context, {required num ammount}) async {
    // Charge charge = Charge()
    //   ..amount = ammount
    //   ..reference = 'test2'
    //   // or ..accessCode = _getAccessCodeFrmInitialization()
    //   ..email = 'elmubarak333@gmail.com';
    // CheckoutResponse response = await PaystackPlugin.checkout(
    //   context,
    //   method: CheckoutMethod.card,
    //   charge: charge,
    // );
    // print(response.status);
  }

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Text('Estimated balance'),
                      SizedBox(height: 10),
                      RichText(
                          text: TextSpan(
                        text: '2.51523875',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: ' NARR COIN = N25,000',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      )),
                      SizedBox(height: 25),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Blockchain wallet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: determinePrimaryColor(context),
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(thickness: 0.8),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.shieldVirus,
                              size: 14,
                              color: determinePrimaryColor(context),
                            ),
                            SizedBox(width: 5),
                            Text('Address: '),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    address.toLowerCase(),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.moneyBill,
                              size: 14,
                              color: determinePrimaryColor(context),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 300,
                              child: Row(
                                children: [
                                  Text('Token Balance: '),
                                  Expanded(
                                    child: Text(
                                      '150 Narr coin',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.moneyBill,
                              size: 14,
                              color: determinePrimaryColor(context),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 300,
                              child: Row(
                                children: [
                                  Text('Token Equivelence (Naira): '),
                                  Expanded(
                                    child: Text(
                                      'N15,000',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.moneyBill,
                              size: 14,
                              color: determinePrimaryColor(context),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 300,
                              child: Row(
                                children: [
                                  Text('Current Conversion Rate: '),
                                  Expanded(
                                      child: Text(
                                    '1 Narr coin = 10,000 Naira',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 11),
                        // Text('Download wallet'),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.ethereum,
                              size: 14,
                              color: determinePrimaryColor(context),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 300,
                              child: Row(
                                children: [
                                  Text('Gas Balance: '),
                                  Text('1.583 Eth'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            text: 'Note:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text:
                                      'If you want to manage your wallet externally, you can download ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ))
                            ],
                          ),
                        ),

                        SizedBox(height: 32),
                        CustomBotton(
                          isLoading: false,
                          buttonTitle: 'Download wallet',
                          buttonColor: determinePrimaryColor(context),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: ContainerWithShadow(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fund Wallet'),
                    SizedBox(height: 7),
                    Divider(thickness: 0.8),
                    Text('Ammount(Naira)'),
                    SizedBox(height: 8),
                    TextField(
                      controller: fundController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          symbol: '₦',
                          // decimalDigits: 1,
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '0',
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                        '${_convertToNarrCoin(_amountFormarter(fundController.text))} Narr coin'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomBotton(
                        buttonTitle: 'Fund',
                        onTap: () {
                          final num _currentAmount =
                              _amountFormarter(fundController.text);
                          _charge(context, ammount: _currentAmount);
                        },
                        isLoading: false,
                        buttonColor: determinePrimaryColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: ContainerWithShadow(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cashout/withdraw'),
                    SizedBox(height: 7),
                    Divider(thickness: 0.8),
                    Text('Ammount(Tokens)'),
                    TextField(
                      controller: cashout,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          symbol: 'Narr',
                          // decimalDigits: 1,
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '0',
                      ),
                    ),
                    Text(
                        '${_convertToNaira(_amountFormarter(cashout.text))} Naira'),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomBotton(
                        buttonTitle: 'Cashout',
                        buttonColor: determinePrimaryColor(context),
                        isLoading: false,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: ContainerWithShadow(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Transfer Tokens'),
                    SizedBox(height: 7),
                    Divider(thickness: 0.8),
                    Text('Recipient Email (Narr Email)'),
                    SizedBox(height: 3),
                    TextField(),
                    SizedBox(height: 15),
                    Text('Ammount(Tokens)'),
                    SizedBox(height: 3),
                    TextField(),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomBotton(
                        buttonColor: determinePrimaryColor(context),
                        buttonTitle: 'Transfer',
                        isLoading: false,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  num _amountFormarter(String ammount) {
    bool startsWithCurrency = ammount.startsWith('₦');
    bool startsWithNarr = ammount.startsWith('Narr');

    if (startsWithCurrency || startsWithNarr) {
      String removeCurrency = ammount.replaceAll('₦', '');
      print('$ammount ==> $removeCurrency');
      String removeDot = removeCurrency.replaceAll('.', '');
      String removedComma = removeDot.replaceAll(',', '');
      String finalAmountFormart = removedComma.replaceAll('Narr', '');

      print('$removeCurrency ==> $finalAmountFormart');
      int _finalAmout = int.parse(finalAmountFormart);
      return _finalAmout;
    } else {
      return 0;
    }
  }

  String _convertToNarrCoin(num naira) {
    num value = naira / 1000000;
    final String finalValue = value.toString();
    setState(() {});
    return finalValue;
  }

  String _convertToNaira(num naira) {
    num value = naira * 100;
    final String finalValue = value.toString();
    setState(() {});
    return finalValue;
  }
}
