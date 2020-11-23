class InstitutionModel {
  String schoolType;
  String alias;
  List<String> schoolName;

  InstitutionModel({this.schoolType, this.alias, this.schoolName});

  InstitutionModel.fromJson(Map<String, dynamic> json) {
    schoolType = json['schooltype'];
    alias = json['alias'];
    schoolName = json['schoolname'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schooltype'] = this.schoolType;
    data['alias'] = this.alias;
    data['lgas'] = this.schoolName;
    return data;
  }
}
