class AnalyticsModel {
  var usersOnline;
  AnalyticsModel({this.usersOnline});
  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    usersOnline = json['usersOnline'];
  }
}
