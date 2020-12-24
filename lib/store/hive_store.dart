import 'package:hive/hive.dart';

class HiveBox {
  Future addToBox({String token, dynamic userObj}) async {
    var tokenStore = await Hive.openBox('token');

    tokenStore.put('token', '$token');
    tokenStore.put('user', '$userObj');

    var savedToken = tokenStore.get('token');
    var savedUser = tokenStore.get('user');
    Map<dynamic, dynamic> userInBox = {
      "savedToken": savedToken,
      "savedUser": savedUser
    };
    // print('token: ${userInBox['savedToken']}, user: ${userInBox['savedUser']}');
    return userInBox;
  }
}
