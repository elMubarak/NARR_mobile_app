import 'package:narr/models/data_model.dart';

class Repository {
  // getLocalByState(String state) => null;

  // List<String> getStates() => null;
  List<Map> getAll() => _institution;

  getNameByType(String schoolType) => _institution
      .map((map) => InstitutionModel.fromJson(map))
      .where((item) => item.schoolType == schoolType)
      .map((item) => item.schoolName)
      .expand((i) => i)
      .toList();

  List<String> getSchools() => _institution
      .map((map) => InstitutionModel.fromJson(map))
      .map((item) => item.schoolType)
      .toList();

  List _institution = [
    {
      "schooltype": "University",
      "alias": "uni",
      "schoolname": [
        "Kaduna State University",
        "Bayero University Kano",
        "Ahmadu Bello University",
      ]
    },
    {
      "schooltype": "Polytechnic",
      "alias": "poly",
      "schoolname": [
        "Kaduna state Polytechnic",
        "Lagos polytechnic ikeja",
        "Nuhu Bamali Polytechnic",
      ]
    },
    {
      "schooltype": "Collage of Education",
      "alias": "collage",
      "schoolname": [
        "Dialog collage of technology",
        "National institution for information and tech",
        "Law school of Nigeria",
      ]
    },
  ];
}
