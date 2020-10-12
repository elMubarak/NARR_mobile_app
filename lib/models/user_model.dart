class UserLoginModel {
  String username;
  String password;

  UserLoginModel({this.username, this.password});

  factory UserLoginModel.fromJson(Map<String, dynamic> data) {
    return UserLoginModel(
      username: data['email'],
      password: data['password'],
    );
  }
}

class UserRegistrationModel {
  String username;
  String password;
  String fname;
  String lname;
  Institution institution;
  UserRegistrationModel(
      {this.username, this.password, this.fname, this.lname, this.institution});

  factory UserRegistrationModel.fromJson(Map<String, dynamic> data) {
    return UserRegistrationModel(
      username: data['email'],
      password: data['password'],
      fname: data['fname'],
      lname: data['lname'],
      institution: Institution.fromJson(data['institution']),
    );
  }
}

class Institution {
  String name;
  String type;

  Institution({this.name, this.type});

  factory Institution.fromJson(Map<String, dynamic> data) {
    return Institution(
      name: data['name'],
      type: data['type'],
    );
  }
}
