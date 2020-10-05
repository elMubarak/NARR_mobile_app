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

  @override
  Widget build(BuildContext context) {
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
                        TextField(
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
                        TextField(
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
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Date of Birth',
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
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
                                child: Text('None'),
                                value: 'None',
                              ),
                              DropdownMenuItem(
                                child: Text('Federal University'),
                                value: 'Federal University',
                              ),
                              DropdownMenuItem(
                                child: Text('Federal Polytechnic'),
                                value: 'Federal Polytechnic',
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
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.id);
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
