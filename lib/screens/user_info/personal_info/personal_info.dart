import 'package:flutter/material.dart';
import 'package:narr/configs.dart';
import 'package:narr/models/user_model.dart';
import 'package:narr/screens/user_info/edit_profile.dart';
import 'package:narr/widgets/container_with_shadow.dart';
import 'package:narr/widgets/school_dash_card.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo(this.currentUser);
  final UserModel currentUser;

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    UserModel user = widget.currentUser;
    DateTime date = DateTime.parse(user.lastLogin);
    DateTime localDate = date.toLocal();
    String dateSlug =
        "${localDate.year.toString()}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}, ${localDate.hour}:${localDate.minute}";
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal information'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, EditProfile.id);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ContainerWithShadow(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/profile.jpg'),
                        radius: 50,
                      ),
                      SizedBox(height: 15),
                      Text(
                        user.userName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        user.userRole,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('More info:'),
                        SizedBox(height: 15),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 15,
                                    child: Icon(Icons.email, size: 20.0),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    user.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 15,
                                    foregroundImage: NetworkImage(
                                      '$baseUrl${user.institution.logo}',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    user.institution.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 15,
                                    child: Icon(Icons.phone, size: 20.0),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    user.phone,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 15,
                                    child: Icon(Icons.house, size: 20.0),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    user.address,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 15,
                                    child:
                                        Icon(Icons.calendar_today, size: 20.0),
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    user.dateOfBirth,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Last Login: '),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    dateSlug,
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Total Upload'),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    user.totalUpload.toString(),
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SchoolDashCard(
              institutionLogo: '$baseUrl${user.institution.logo}',
              institutionName: user.institution.name,
              institutionAcronym: user.institution.acronym,
              institutionType: user.institution.type,
              year: user.institution.year,
              ownership: user.institution.ownerShip,
              url: user.institution.url,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
