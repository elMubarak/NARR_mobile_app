import 'package:hive/hive.dart';

class HiveBox {
  void saveToken(String token) async {
    var tokenStore = await Hive.openBox('saved_token');
    tokenStore.put('token', '$token');
  }

  void saveUser(Map<String, dynamic> user) async {
    var userStore = await Hive.openBox('saved_user');
    userStore.put('user', user);
  }

  Future addToBox({String token, Map<String, dynamic> userObj}) async {
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

  Future<String> getSavedToken() async {
    var store = await Hive.openBox('saved_token');
    String savedData = await store.get('token');
    return savedData;
  }

  Future<Map<String, dynamic>> getSavedUser() async {
    var store = await Hive.openBox('saved_user');
    Map<String, dynamic> savedData = await store.get('user');
    return savedData;
  }

  clearToken() async {
    // ignore: unused_local_variable
    var store = await Hive.openBox('local-user');
    // store.put('token', null);
    // store.put('user', null);
    Hive.box('local-user').clear();
  }
}
