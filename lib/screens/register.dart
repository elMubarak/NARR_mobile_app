import 'package:flutter/material.dart';
import 'package:narr/screens/home.dart';
import 'package:narr/screens/login.dart';
import 'package:narr/widgets/custom_button.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String selectedInstitutionType = 'Institution Type';
  String selectedInstitutionName = 'Institution Name';
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
      body: ListView(
        children: <Widget>[
          Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00a368),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2.5),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'First Name',
                    filled: true,
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
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    filled: true,
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
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(HomeScreen.id);
                  },
                  child: CustomBotton(
                    buttonTitle: 'Register',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(Login.id);
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(
                          color: Color(0xff00a368),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
