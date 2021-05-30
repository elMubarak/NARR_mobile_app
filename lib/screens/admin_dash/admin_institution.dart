import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/helpers/dropdownHelper.dart';
import 'package:narr/services/backend_service.dart';

class AllInstitution extends StatefulWidget {
  static String id = '/Allinstitutions';
  @override
  _AllInstitutionState createState() => _AllInstitutionState();
}

class _AllInstitutionState extends State<AllInstitution> {
  DropdownHelper _dropdownHelper = DropdownHelper();
  String url = '$serverUrl/institution';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Institutions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButton(
              items: _dropdownHelper.getInstitutionTypeDropdownItems(),
              onChanged: (value) {
                setState(() {
                  _dropdownHelper.selectedInstitutionType = value;
                });
                // print(_dropdownHelper.selectedInstitutionType);
              },
              icon: Icon(
                Icons.filter_list_alt,
                color: Colors.white,
              ),
              underline: Container(),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: NetworkHelper(url: url).getInstitutionName(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var institution = snapshot.data[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('$baseUrl${institution['logo']}'),
                ),
                title: Text('${institution['name']}'),
                subtitle: Text('${institution['acronym']}'),
                trailing: Text('${institution['year']}'),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return Singleresearcher(
                  //         researcherId: Allinstitution['_id'],
                  //       );
                  //     },
                  //   ),
                  // );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: snapshot.data.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_sharp,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
              size: 11,
            ),
          ],
        ),
        onPressed: null,
      ),
    );
  }
}
