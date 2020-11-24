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
  String email;
  String password;
  String fname;
  String lname;

  UserRegistrationModel({this.email, this.password, this.fname, this.lname});

  UserRegistrationModel.fromData(Map<String, dynamic> values)
      : email = values['email'],
        password = values['password'],
        fname = values['fName'],
        lname = values['lName'];
  // institution = Institution.fromData(values['institution']);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fName': fname,
      'lName': lname,
    };
  }
}

// class Institution {
//   String name;
//   String type;

//   Institution({this.name, this.type});

//   Institution.fromData(Map<String, dynamic> data)
//       : name = data['name'],
//         type = data['type'];

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'type': type,
//     };
// //   }
// }
