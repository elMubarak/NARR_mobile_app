import 'package:flutter/material.dart';

class DropdownHelper {
  String selectedInstitutionType = '';
  String selectedInstitutionName = '';
  String selectedCategory = '';
  String selectedGenre = '';
  String selectedAccessType = '';
  String selectedFilter = '';

  List<String> institutionType = [
    'University',
    'Polytechnic',
    'Collage of Education',
    'Monotechnic',
    'Independent Researcher'
  ];
  List<String> universites = [
    'Ahmadu Bello University',
    'Bayero University Kano',
    'Kaduna State University',
  ];

  List<String> poly = [
    'Kaduna Polytechnic',
    'Nuhu Bamali Polytechnic',
  ];

  List<String> collegeOfEducation = [
    'FCE Zaria',
    'FCE Katsina',
  ];

  List<String> monotechnic = [
    'Dialogue Institute of Tech',
    'Khemsafe Computers',
  ];

  List<String> filters = [
    'Science',
    'Art',
    'Law',
    'Engineering',
    'Social Science',
    'Technology'
  ];

  List<String> category = [
    'Arts',
    'Education',
    'Engineering',
    'Social Science',
    'Sciences'
  ];

  List<String> genres = ['Project', 'Thesis-Dissertation', 'Journel', 'eBook'];

  List<String> accessType = [
    'Free',
    'Payed',
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

  List<DropdownMenuItem> getCollegeOfEducationName() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String name in collegeOfEducation) {
      var newItem = DropdownMenuItem(
          child: Text(
            name,
          ),
          value: name);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getMonotechnicName() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String name in monotechnic) {
      var newItem = DropdownMenuItem(
          child: Text(
            name,
          ),
          value: name);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getFilterDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String filter in filters) {
      var newItem = DropdownMenuItem(
        child: Text(filter),
        value: filter,
      );
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getCategoryDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String cat in category) {
      var newItem = DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getGenreDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String gen in genres) {
      var newItem = DropdownMenuItem(
        child: Text(gen),
        value: gen,
      );
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getaccessTypeDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String type in accessType) {
      var newItem = DropdownMenuItem(
        child: Text(type),
        value: type,
      );
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }
}
