import 'package:flutter/material.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/formCard.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String selectedInstitutionType = 'Institution Type';
  String selectedInstitutionName = 'Institution Name';
  String password;
  String cPassword;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  // List<String> institutionType = [
  //   'Institution Type',
  //   'None',
  //   'Federal University',
  //   'Federal Poly',
  //   'State University',
  //   'State Poly'
  // ];
  // List<String> institutionName = [
  //   'ABU',
  //   'BUK',
  //   'KASU',
  //   'KadPoly',
  //   'FUDMA',
  //   'ATBU'
  // ];
  // getInstitutionType() {
  //   List<DropdownMenuItem<String>> newdropdownItemList = [];
  //   for (var item in institutionType) {
  //     var newInstTypeItem = DropdownMenuItem(
  //       child: Text(item),
  //       value: item,
  //     );
  //     newdropdownItemList.add(newInstTypeItem);
  //   }
  //   return newdropdownItemList;
  // }
  DateTime selectedDate = DateTime.now();
  bool isPicked = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        isPicked = true;
      }); //get
  }

  @override
  Widget build(BuildContext context) {
    String dateOfBirth = '${selectedDate.toLocal()}'.split(' ')[0];
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
                        ),
                        SizedBox(
                          height: 20.0,
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
                        ),
                        SizedBox(
                          height: 20.0,
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
                        ),
                        SizedBox(
                          height: 20.0,
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
                                  isPicked ? dateOfBirth : 'Date of Birth',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // TextField(
                        //   decoration: InputDecoration(
                        //     border: InputBorder.none,
                        //     hintText: 'Date of Birth',
                        //     filled: true,
                        //     prefixIcon: Icon(Icons.calendar_today),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            filled: true,
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        DropdownContainer(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            value: selectedInstitutionType,
                            items: [
                              DropdownMenuItem(
                                child: Text('Institution Type'),
                                value: 'Institution Type',
                              ),
                              DropdownMenuItem(
                                child: Text('University'),
                                value: 'University',
                              ),
                              DropdownMenuItem(
                                child: Text('Polytechnic'),
                                value: 'Polytechnic',
                              ),
                              DropdownMenuItem(
                                child: Text('College Of Education'),
                                value: 'College Of Education',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedInstitutionType = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        DropdownContainer(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            value: selectedInstitutionName,
                            items: [
                              DropdownMenuItem(
                                child: Text('Institution Name'),
                                value: 'Institution Name',
                              ),
                              DropdownMenuItem(
                                child: Text('BUK'),
                                value: 'BUK',
                              ),
                              DropdownMenuItem(
                                child: Text('ABU'),
                                value: 'ABU',
                              ),
                              DropdownMenuItem(
                                child: Text('KASU'),
                                value: 'KASU',
                              ),
                              DropdownMenuItem(
                                child: Text('Others'),
                                value: 'KASU',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedInstitutionName = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 6) {
                              return 'Password less than 6 characters';
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
                          height: 20.0,
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
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _formKey.currentState.save();
                              });
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.id);
                            }
                          },
                          child: CustomBotton(
                            buttonTitle: 'Register',
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
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
      padding: EdgeInsets.only(
        left: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: child,
    );
  }
}
