class InstitutionModel {
  String state;
  String alias;
  List<String> lgas;

  InstitutionModel({this.state, this.alias, this.lgas});

  InstitutionModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    alias = json['alias'];
    lgas = json['lgas'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['alias'] = this.alias;
    data['lgas'] = this.lgas;
    return data;
  }
}
