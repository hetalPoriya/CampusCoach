// To parse this JSON data, do
//
//     final studentLogin = studentLoginFromJson(jsonString);

import 'dart:convert';

StudentLogin studentLoginFromJson(String str) =>
    StudentLogin.fromJson(json.decode(str));

String studentLoginBodyToJson(StudentLoginBody data) =>
    json.encode(data.toMap());

String studentSignUpBodyToJson(StudentSignUpBody data) =>
    json.encode(data.toMap());

class StudentLoginBody {
  String email;
  String password;

  StudentLoginBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}

class StudentSignUpBody {
  String fullName;
  String email;
  String password;
  String mobileNumber;

  StudentSignUpBody(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.mobileNumber});

  Map<String, dynamic> toMap() => {
        "fullname": fullName,
        "email": email,
        "password": password,
        "mobile_number": mobileNumber
      };
}

class StudentLogin {
  StudentLogin({
    this.error,
    this.data,
    this.imageUrl,
    this.errorMsg,
  });

  String? error;
  StudentLoginUser? data;
  String? imageUrl;
  String? errorMsg;

  factory StudentLogin.fromJson(Map<String, dynamic> json) => StudentLogin(
        error: json["error"],
        data: json["data"] == null
            ? null
            : StudentLoginUser.fromJson(json["data"]),
        imageUrl: json["image_url"],
        errorMsg: json["error_msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data?.toJson(),
        "image_url": imageUrl,
        "error_msg": errorMsg,
      };
}

class StudentLoginUser {
  StudentLoginUser({
    this.id,
    this.city,
    this.fatherName,
    this.country,
    this.dateOfBirth,
    this.gender,
    this.deviceId,
    this.emailId,
    this.fatherFirstName,
    this.fatherLastName,
    this.firstName,
    this.image,
    this.lastName,
    this.mobileNumber,
    this.password,
    this.pinCode,
    this.rollNumber,
    this.school,
    this.state,
    this.userClass,
    this.userName,
    this.deviceToken,
    this.verifiedNumber,
    this.otp,
    this.status,
    this.token,
    this.blockStatus,
    this.createdDate,
  });

  String? id;
  dynamic city;
  String? fatherName;
  dynamic country;
  dynamic dateOfBirth;
  String? gender;
  dynamic deviceId;
  String? emailId;
  dynamic fatherFirstName;
  dynamic fatherLastName;
  String? firstName;
  dynamic image;
  dynamic lastName;
  String? mobileNumber;
  String? password;
  dynamic pinCode;
  dynamic rollNumber;
  dynamic school;
  dynamic state;
  dynamic userClass;
  dynamic userName;
  dynamic deviceToken;
  String? verifiedNumber;
  String? otp;
  String? status;
  String? token;
  String? blockStatus;
  DateTime? createdDate;

  factory StudentLoginUser.fromJson(Map<String, dynamic> json) =>
      StudentLoginUser(
        id: json["id"],
        city: json["city"],
        fatherName: json["father_name"],
        country: json["country"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        deviceId: json["device_id"],
        emailId: json["email_id"],
        fatherFirstName: json["father_first_name"],
        fatherLastName: json["father_last_name"],
        firstName: json["first_name"],
        image: json["image"],
        lastName: json["last_name"],
        mobileNumber: json["mobile_number"],
        password: json["password"],
        pinCode: json["pinCode"],
        rollNumber: json["roll_number"],
        school: json["School"],
        state: json["state"],
        userClass: json["user_class"],
        userName: json["user_name"],
        deviceToken: json["device_token"],
        verifiedNumber: json["verified_number"],
        otp: json["otp"],
        status: json["status"],
        token: json["token"],
        blockStatus: json["block_status"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "father_name": fatherName,
        "country": country,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "device_id": deviceId,
        "email_id": emailId,
        "father_first_name": fatherFirstName,
        "father_last_name": fatherLastName,
        "first_name": firstName,
        "image": image,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        "password": password,
        "pinCode": pinCode,
        "roll_number": rollNumber,
        "School": school,
        "state": state,
        "user_class": userClass,
        "user_name": userName,
        "device_token": deviceToken,
        "verified_number": verifiedNumber,
        "otp": otp,
        "status": status,
        "token": token,
        "block_status": blockStatus,
        "created_date": createdDate?.toIso8601String(),
      };
}
