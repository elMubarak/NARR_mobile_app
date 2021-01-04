import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/screens/login.dart';
// import 'package:narr/screens/verify_email.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/formCard.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String fname;
  String lname;
  String email;
  String phone;
  String address;
  String password;
  String cPassword;

  bool _obscureText = true;
  bool showSpiner = false;
  bool isClickable = false;
  String myUrl = '$serverUrl/auth/register';
  final _formKey = GlobalKey<FormState>();

  static DateTime selectedDate = DateTime.now();
  bool isPicked = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isPicked = true;
      }); //get
    }
  }

  DropdownHelper _dropdownHelper = DropdownHelper();
  List<DropdownMenuItem> item;

  @override
  Widget build(BuildContext context) {
    String dob = '${selectedDate.toLocal()}'.split(' ')[0];
    if (_dropdownHelper.selectedInstitutionType ==
        _dropdownHelper.institutionType[0]) {
      item = _dropdownHelper.getUniversityName();
    } else if (_dropdownHelper.selectedInstitutionType ==
        _dropdownHelper.institutionType[1]) {
      item = _dropdownHelper.getPolyName();
    } else if (_dropdownHelper.selectedInstitutionType ==
        _dropdownHelper.institutionType[2]) {
      item = _dropdownHelper.getCollegeOfEducationName();
    } else if (_dropdownHelper.selectedInstitutionType ==
        _dropdownHelper.institutionType[3]) {
      item = _dropdownHelper.getMonotechnicName();
    }

    return Scaffold(
      backgroundColor: Color(0xff00a368),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                Text(
                  'Hello! Researcher ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                FormCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text(
                          'CREATE ACCOUNT',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xff00a368),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'First Name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'First Name',
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (value) {
                            fname = value;
                          },
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Last Name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Last Name',
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (value) {
                            lname = value;
                          },
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email is required';
                            } else if (!value.contains('@')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (value) {
                            email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  isPicked ? dob : 'Date of Birth',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            filled: true,
                            prefixIcon: Icon(Icons.phone),
                          ),
                          onChanged: (value) {
                            phone = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Address',
                            filled: true,
                            prefixIcon: Icon(Icons.home),
                          ),
                          onChanged: (value) {
                            address = value;
                          },
                        ),
                        SizedBox(height: 15.0),
                        DropdownContainer(
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select an institution type';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.school),
                            ),
                            hint: Text(
                              'Institution Type',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            items: _dropdownHelper
                                .getInstitutionTypeDropdownItems(),
                            onChanged: (value) {
                              setState(() {
                                _dropdownHelper.selectedInstitutionType = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DropdownContainer(
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select an institution name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.school),
                            ),
                            hint: Text(
                              'Institution Name',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            items: item,
                            onChanged: (value) {
                              setState(() {
                                _dropdownHelper.selectedInstitutionName = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 6) {
                              return 'Password can\t be less than 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(Icons.visibility),
                            ),
                          ),
                          obscureText: _obscureText,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password is required';
                            } else if (password != cPassword) {
                              return 'Passwords not matched';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscureText,
                          onChanged: (value) {
                            cPassword = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        CustomBotton(
                            isLoading: isClickable,
                            buttonTitle: 'Register',
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  isClickable = true;
                                });

                                NetworkHelper(
                                  url: myUrl,
                                )
                                    .userRegistration(
                                      email,
                                      password,
                                      fname,
                                      lname,
                                      dob,
                                      phone,
                                      address,
                                      _dropdownHelper.selectedInstitutionType,
                                      _dropdownHelper.selectedInstitutionName,
                                      context,
                                    )
                                    .whenComplete(
                                      () => setState(() {
                                        isClickable = false;
                                      }),
                                    );

                                // Navigator.pushNamed(context, VerifyAccount.id);

                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Login.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Already have an account?'),
                                  SizedBox(width: 5),
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Color(0xff00a368),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownContainer extends StatelessWidget {
  final Widget child;

  DropdownContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: child,
    );
  }
}

class Institution {
  String name;
  String type;
  Institution({this.name, this.type});

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      name: json['name'],
      type: json['type'],
    );
  }
}
