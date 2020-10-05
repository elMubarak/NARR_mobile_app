class User {
  int id;
  String username;
  String password;

  String token;
  User({this.id, this.username, this.token, this.password});

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username: data['email'],
        password: data['password'],
        token: data['token'],
      );

  Map<String, dynamic> toJson() =>
      {"id": this.id, "username": this.username, "token": this.token};
}

class UserLogin {
  String username;
  String password;

  UserLogin({this.username, this.password});

  Map<String, dynamic> toJson() =>
      {"username": this.username, "password": this.password};
}

class Token {
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token']);
  }
}
