class InstitutionModel {
  late String schoolType;
  late String alias;
  late List<String> schoolName;
  InstitutionModel(
      {this.schoolType = '', this.alias = '', required this.schoolName});

  InstitutionModel.fromJson(Map<String, dynamic> json) {
    this.schoolType = json['schooltype'];
    this.alias = json['alias'];
    this.schoolName = json['schoolname'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schooltype'] = this.schoolType;
    data['alias'] = this.alias;
    data['lgas'] = this.schoolName;
    return data;
  }
}
