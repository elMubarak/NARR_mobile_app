import 'package:mobx/mobx.dart';

part 'online_users_mobx.g.dart';

class OnlineUsers = OnlineUsersBase with _$OnlineUsers;

abstract class OnlineUsersBase with Store {
  @observable
  List numberOfUsersOnline = [];

  @action
  void getNumberOfUsersOnline(List usersOnline) {
    numberOfUsersOnline = usersOnline;
  }
}
