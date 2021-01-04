import 'package:flutter/material.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/services/backend_service.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/dropdown_container.dart';

class EditProfile extends StatefulWidget {
  static String id = '/editProfile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DropdownHelper _dropdownHelper = DropdownHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     IconButton(
                //       icon: Icon(Icons.arrow_back),
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //     ),
                //   ],
                // ),

                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: userObj['phone'],
                    filled: true,
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: userObj['address'],
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 15,
                ),
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
                    items: _dropdownHelper.getInstitutionTypeDropdownItems(),
                    onChanged: (value) {
                      setState(() {
                        _dropdownHelper.selectedInstitutionType = value;
                      });
                    },
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'New Password',
                    filled: true,
                    prefixIcon: Icon(Icons.lock),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 15.0,
                ),
                CustomBotton(
                  buttonTitle: 'Confirm',
                  isLoading: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
