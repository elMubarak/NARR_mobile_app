import 'package:hive/hive.dart';

class HiveBox {
  Future addToBox({String token, dynamic userObj}) async {
    var userStore = await Hive.openBox('local-user');

    userStore.put('token', '$token');
    userStore.put('user', userObj);

    String savedToken = userStore.get('token');
    dynamic savedUser = userStore.get('user');
    Map<String, dynamic> userInBox = {
      "savedToken": savedToken,
      "savedUser": savedUser
    };
    return userInBox;
  }

  getUserAndToken(String data) async {
    var store = await Hive.openBox('local-user');
    dynamic savedData = await store.get(data);

    return savedData;
  }
}
