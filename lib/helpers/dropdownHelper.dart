import 'package:flutter/material.dart';

class DropdownHelper {
  String selectedInstitutionType = '';
  String selectedInstitutionName = '';

  List<String> institutionType = [
    'University',
    'Polytechnic',
    'Collage of Education',
  ];
  List<String> institutionName = [
    'Ahmadu Bello University',
    'Bayero University Kano',
    'Kaduna State University'
  ];

  List<DropdownMenuItem> getInstitutionTypeDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String type in institutionType) {
      var newItem = DropdownMenuItem(
        child: Text(type),
        value: type,
      );
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getInstitutionNameDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String name in institutionName) {
      var newItem = DropdownMenuItem(child: Text(name), value: name);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }
}
