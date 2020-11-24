import 'package:flutter/material.dart';

class DropdownHelper {
  String selectedInstitutionType = '';
  String selectedInstitutionName = '';

  List<String> institutionType = [
    'University',
    'Polytechnic',
    'Collage of Education',
  ];
  List<String> universites = [
    'Ahmadu Bello University',
    'Bayero University Kano',
    'Kaduna State University'
  ];

  List<String> poly = [
    'Kaduna Polytechnic',
    'Nuhu Bamali Polytechnic',
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

  List<DropdownMenuItem> getUniversityName() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String name in universites) {
      var newItem = DropdownMenuItem(child: Text(name), value: name);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getPolyName() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String name in poly) {
      var newItem = DropdownMenuItem(child: Text(name), value: name);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }
}
