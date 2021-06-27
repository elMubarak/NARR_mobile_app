import 'package:hive/hive.dart';

class HiveBox {
  //token box
  void saveToken(String token) async {
    var tokenStore = await Hive.openBox('saved_token');
    tokenStore.put('token', '$token');
  }

  Future<String> getSavedToken() async {
    var store = await Hive.openBox('saved_token');
    String savedData = await store.get('token');
    return savedData;
  }

//User box
  void saveUser(Map<String, dynamic> user) async {
    var userStore = await Hive.openBox('saved_user');
    userStore.put('user', user);
  }

  Future getSavedUser() async {
    var store = await Hive.openBox('saved_user');
    Map<dynamic, dynamic> savedUser = await store.get('user');
    if (savedUser != null) {
      Map<String, dynamic> hashedUser =
          savedUser.map((key, value) => MapEntry(key.toString(), value));

      return hashedUser;
    }
  }

  clearToken() async {
    Hive.box('saved_user').clear();
    Hive.box('saved_token').clear();
  }
}
