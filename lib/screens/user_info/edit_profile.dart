import 'package:flutter/material.dart';
import 'package:narr/global/global_vars.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/store/hive_store.dart';
import 'package:narr/widgets/custom_button.dart';
import 'package:narr/widgets/dropdown_container.dart';

class EditProfile extends StatefulWidget {
  static String id = '/editProfile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DropdownHelper _dropdownHelper = DropdownHelper();
  HiveBox _box = HiveBox();

  Future getStoredUserObject() async {
    dynamic savedUser = await _box.getSavedUser();
    return savedUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: FutureBuilder<dynamic>(
        future: getStoredUserObject(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: snapshot.data['phone'],
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
                        hintText: snapshot.data['address'],
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    DropdownContainer(
                      child: DropdownButtonFormField<dynamic>(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.school),
                        ),
                        hint: Text(
                          snapshot.data['institution']['type'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        items:
                            _dropdownHelper.getInstitutionTypeDropdownItems(),
                        onChanged: (value) {
                          setState(() {
                            _dropdownHelper.selectedInstitutionType = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownContainer(
                      child: DropdownButtonFormField<dynamic>(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.school),
                        ),
                        hint: Text(
                          snapshot.data['institution']['name'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        items: _dropdownHelper.getUniversityName(),
                        onChanged: (value) {
                          setState(() {
                            _dropdownHelper.selectedInstitutionName = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                      onTap: () {},
                      buttonColor: determinePrimaryColor(context),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
