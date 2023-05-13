import 'dart:convert';

String bankDetailsModelToJson(BankDetailsModel data) =>
    json.encode(data.toMap());

class BankDetailsModel {
  String coachId;
  String bankName;
  String accountHolderName;
  String accountNumber;
  String ifscCode;

  BankDetailsModel({
    required this.coachId,
    required this.bankName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
  });

  Map<String, dynamic> toMap() => {
        "coach_id": coachId,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
      };
}
