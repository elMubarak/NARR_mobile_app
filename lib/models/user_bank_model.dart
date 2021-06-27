class BankDetailsModel {
  final String bankName;
  final String bankAccountName;
  final String bankAccountNumber;
  final String bvn;

  BankDetailsModel({
    required this.bankName,
    required this.bankAccountName,
    required this.bankAccountNumber,
    required this.bvn,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> data) {
    return BankDetailsModel(
      bankName: data['bankName'] as String,
      bankAccountName: data['accountName'] as String,
      bankAccountNumber: data['accountNumber'] as String,
      bvn: data['bvn'] as String,
    );
  }
}
