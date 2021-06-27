class EmailsModel {
  final String from;
  final String to;
  final String subject;
  final List<String> cc;
  final List<String> vcc;
  final String body;
  final dynamic attachment;

  EmailsModel({
    this.subject = '',
    this.from = '',
    this.to = '',
    required this.cc,
    required this.vcc,
    this.attachment,
    this.body = '',
  });
  factory EmailsModel.fromJson(Map<String, dynamic> data) {
    return EmailsModel(
      cc: [],
      vcc: [],
    );
  }
}

//to move later

List<EmailsModel> selectedEmail = <EmailsModel>[];
Future<List<EmailsModel>> getEmails() {
  final List<EmailsModel> list = <EmailsModel>[
    EmailsModel(
      from: 'mubarak@narr.ng',
      to: 'musadams@narr.ng',
      subject: 'Feild study',
      body: 'Testing something cool',
      vcc: [],
      cc: [],
    ),
    EmailsModel(
      from: 'mubarak@narr.ng',
      to: 'zainabjj@narr.ng',
      subject: 'Narr study',
      body: 'Testing something cool',
      cc: [],
      vcc: [],
    ),
    EmailsModel(
      from: 'mubarak@narr.ng',
      subject: 'Game',
      to: 'aliyu@narr.ng',
      body: 'Testing something cool',
      vcc: [],
      cc: [],
    ),
  ];

  return Future<List<EmailsModel>>.value(list);
}
