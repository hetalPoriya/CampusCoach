// To parse this JSON data, do
//
//     final coachLogin = coachLoginFromJson(jsonString);

import 'dart:convert';

CoachLogin coachLoginFromJson(String str) =>
    CoachLogin.fromJson(json.decode(str));

String coachLoginBodyToJson(CoachLoginBody data) => json.encode(data.toMap());
String coachSignUpBodyToJson(CoachSignUpBody data) => json.encode(data.toMap());

class CoachLoginBody {
  String email;
  String password;

  CoachLoginBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}

class CoachSignUpBody {
  String fullName;
  String email;
  String password;
  String mobileNumber;

  CoachSignUpBody(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.mobileNumber});

  Map<String, dynamic> toMap() => {
        "name": fullName,
        "email_id": email,
        "password": password,
        "mobile": mobileNumber
      };
}

class CoachLogin {
  CoachLogin({
    this.error,
    this.data,
    this.errorMsg,
  });

  String? error;
  CoachLoginUser? data;
  String? errorMsg;

  factory CoachLogin.fromJson(Map<String, dynamic> json) => CoachLogin(
        error: json["error"],
        data:
            json["data"] == null ? null : CoachLoginUser.fromJson(json["data"]),
        errorMsg: json["error_msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data?.toJson(),
        "error_msg": errorMsg,
      };
}

class CoachLoginUser {
  CoachLoginUser({
    this.id,
    this.name,
    this.mobileNo,
    this.email,
    this.password,
    this.orgPassword,
    this.address,
    this.image,
    this.qualification,
    this.price,
    this.newSessionPrice,
    this.experience,
    this.areaOfExpertise,
    this.createdDate,
    this.removeStatus,
    this.aboutMe,
    this.status,
    this.token,
    this.youtubeVideo,
    this.packageDesc,
    this.packagePrice,
    this.packageEnable,
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.ifscCode,
  });

  String? id;
  String? name;
  String? mobileNo;
  String? email;
  String? password;
  String? orgPassword;
  String? address;
  String? image;
  String? qualification;
  String? price;
  String? newSessionPrice;
  String? experience;
  String? areaOfExpertise;
  DateTime? createdDate;
  String? removeStatus;
  String? aboutMe;
  String? status;
  String? token;
  String? youtubeVideo;
  String? packageDesc;
  String? packagePrice;
  String? packageEnable;
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;

  factory CoachLoginUser.fromJson(Map<String, dynamic> json) => CoachLoginUser(
        id: json["id"],
        name: json["name"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        password: json["password"],
        orgPassword: json["org_password"],
        address: json["address"],
        image: json["image"],
        qualification: json["qualification"],
        price: json["price"],
        newSessionPrice: json["new_session_price"],
        experience: json["experience"],
        areaOfExpertise: json["area_of_expertise"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        removeStatus: json["remove_status"],
        aboutMe: json["about_me"],
        status: json["status"],
        token: json["token"],
        youtubeVideo: json["youtube_video"],
        packageDesc: json["package_desc"],
        packagePrice: json["package_price"],
        packageEnable: json["package_enable"],
        bankName: json["bank_name"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        ifscCode: json["ifsc_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_no": mobileNo,
        "email": email,
        "password": password,
        "org_password": orgPassword,
        "address": address,
        "image": image,
        "qualification": qualification,
        "price": price,
        "new_session_price": newSessionPrice,
        "experience": experience,
        "area_of_expertise": areaOfExpertise,
        "created_date": createdDate?.toIso8601String(),
        "remove_status": removeStatus,
        "about_me": aboutMe,
        "status": status,
        "token": token,
        "youtube_video": youtubeVideo,
        "package_desc": packageDesc,
        "package_price": packagePrice,
        "package_enable": packageEnable,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
      };
}
