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

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String phone;
  final String address;
  final String dateOfBirth;
  final Institution institution;
  final String userType;
  final String userRole;
  final String status;
  final int totalUpload;
  final List specialization;
  final List interest;

  UserModel(
      {this.id,
      this.userName,
      this.email,
      this.phone,
      this.address,
      this.dateOfBirth,
      this.institution,
      this.userType,
      this.userRole,
      this.status,
      this.totalUpload,
      this.specialization,
      this.interest});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['_id'] as String,
      userName: data['fullName'] as String,
      phone: data['phone'] as String,
      email: data['email'] as String,
      address: data['address'] as String,
      dateOfBirth: data['dob'] as String,
      status: data['status'] as String,
      userRole: data['userRole'] as String,
      userType: data['userType'] as String,
      totalUpload: data['totalUploads'] as int,
      specialization: data['specialization'] as List,
      interest: data['interests'] as List,
      institution: Institution.fromJson(data['institution']),
    );
  }
}

class Institution {
  final String name;
  final String type;

  Institution({this.name, this.type});

  factory Institution.fromJson(Map<dynamic, dynamic> data) {
    return Institution(
      name: data['name'] as String,
      type: data['type'] as String,
    );
  }
}
