class SchoolModel {
  String institutionName;
  String institutionAcronym;
  String institutionLogo;
  String institutionURL;
  String institutionType;
  String institutionOwnerShip;
  String institutionYear;
  SchoolModel(
      {this.institutionName,
      this.institutionAcronym,
      this.institutionLogo,
      this.institutionURL,
      this.institutionType,
      this.institutionOwnerShip,
      this.institutionYear});
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
