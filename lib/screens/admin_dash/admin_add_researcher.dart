import 'package:flutter/material.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/dropdown_container.dart';
import 'package:narr/widgets/formCard.dart';

import '../../configs.dart';

class AddResearcher extends StatefulWidget {
  static String id = '/addResearcher';
  @override
  _AddResearcherState createState() => _AddResearcherState();
}

class _AddResearcherState extends State<AddResearcher> {
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

  bool institutonTypeFlag = false;
  bool institutonNameFlag = false;
  DropdownHelper _dropdownHelper = DropdownHelper();
  List<DropdownMenuItem> item;
  List institutionType = [];
  List institutionName = [];
  List institutionCategory = ['Federal', 'State', 'Private', 'Independent'];
  Map<String, dynamic> institutionObject;
  @override
  void initState() {
    super.initState();
    institutionTypeDropdown();
  }

  @override
  Widget build(BuildContext context) {
    String dob = '${selectedDate.toLocal()}'.split(' ')[0];
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                FormCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text(
                          'Add Researcher',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.blue,
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
                            items: institutionType?.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item),
                                    value: item.toString(),
                                  );
                                })?.toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                _dropdownHelper.selectedInstitutionType = value;
                                institutonTypeFlag = true;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        institutonTypeFlag
                            ? DropdownContainer(
                                child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select an institution category';
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
                                    'Institution Category',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  items: institutionCategory?.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item),
                                          value: item.toString(),
                                        );
                                      })?.toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      _dropdownHelper
                                          .selectedInstitutionCategory = value;
                                      institutionNameDropdown(
                                          type: _dropdownHelper
                                              .selectedInstitutionType,
                                          category: _dropdownHelper
                                              .selectedInstitutionCategory);
                                      institutonNameFlag = true;
                                    });
                                  },
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 15.0,
                        ),
                        institutonNameFlag
                            ? DropdownContainer(
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
                                  isExpanded: true,
                                  items: _dropdownHelper
                                          .getInstitutionNameDropdownItems(
                                              institutionName) ??
                                      [],
                                  onChanged: (value) async {
                                    await NetworkHelper(
                                            url:
                                                '$serverUrl/institution/getbyname')
                                        .getSingleInstitutionByName(value)
                                        .then((value) {
                                      institutionObject = value;
                                    });
                                  },
                                ),
                              )
                            : Container(),
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
                            buttonColor: Colors.blue,
                            isLoading: isClickable,
                            buttonTitle: 'Register',
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  isClickable = true;
                                });

                                NetworkHelper(
                                  url: '$mockServerUrl/auth/register',
                                )
                                    .addResearcher(
                                  username: email,
                                  password: password,
                                  fname: fname,
                                  lname: lname,
                                  dob: dob,
                                  phone: phone,
                                  address: address,
                                  institution: institutionObject['institution'],
                                  context: context,
                                )
                                    .then((value) {
                                  setState(() {
                                    isClickable = false;
                                  });
                                });
                              }
                            }),
                        SizedBox(height: 35),
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

  Future institutionTypeDropdown() async {
    await NetworkHelper(url: '$serverUrl/institution/types')
        .getInstitutionType()
        .then((value) {
      setState(() {
        institutionType = value;
      });
    });
  }

  Future institutionNameDropdown({String type, String category}) async {
    await NetworkHelper(url: '$serverUrl/institution/$type/$category')
        .getInstitutionName()
        .then((value) {
      setState(() {
        institutionName = value;
      });
    });
  }
}
