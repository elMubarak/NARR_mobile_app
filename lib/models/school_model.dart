class SchoolModel {
  late String institutionName;
  late String institutionAcronym;
  late String institutionLogo;
  late String institutionURL;
  late String institutionType;
  late String institutionOwnerShip;
  late String institutionYear;
  SchoolModel(
      {this.institutionName = '',
      this.institutionAcronym = '',
      this.institutionLogo = '',
      this.institutionURL = '',
      this.institutionType = '',
      this.institutionOwnerShip = '',
      this.institutionYear = ''});
  SchoolModel.fromJson(Map<String, dynamic> json) {
    institutionName = json[''];
    institutionType = json[''];
    institutionAcronym = json[''];
    institutionLogo = json[''];
    institutionURL = json[''];
    institutionOwnerShip = json[''];
    institutionYear = json[''];
  }
}
