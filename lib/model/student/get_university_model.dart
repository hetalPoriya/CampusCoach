// To parse this JSON data, do
//
//     final getUniversityModel = getUniversityModelFromJson(jsonString);

import 'dart:convert';

GetUniversityModel getUniversityModelFromJson(String str) => GetUniversityModel.fromJson(json.decode(str));

String getUniversityModelToJson(GetUniversityModel data) => json.encode(data.toJson());

class GetUniversityModel {
  GetUniversityModel({
    this.error,
    this.data,
    this.errorMsg,
  });

  String? error;
  List<GetUniversityData>? data;
  String? errorMsg;

  factory GetUniversityModel.fromJson(Map<String, dynamic> json) => GetUniversityModel(
    error: json["error"],
    data: json["data"] == null ? [] : List<GetUniversityData>.from(json["data"]!.map((x) => GetUniversityData.fromJson(x))),
    errorMsg: json["error_msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "error_msg": errorMsg,
  };
}

class GetUniversityData {
  GetUniversityData({
    this.id,
    this.applicationNo,
    this.universityImage,
    this.applicationType,
    this.institutionName,
    this.address,
    this.city,
    this.district,
    this.pincode,
    this.state,
    this.region,
    this.instType,
    this.program,
    this.course,
    this.freeCounselling,
    this.level,
    this.specialization,
    this.intake,
    this.streamId,
    this.wishlistStatus,
    this.counselling,
    this.image,
  });

  String? id;
  String? applicationNo;
  String? universityImage;
  String? applicationType;
  String? institutionName;
  String? address;
  String? city;
  String? district;
  String? pincode;
  String? state;
  String? region;
  String? instType;
  String? program;
  String? course;
  String? freeCounselling;
  String? level;
  String? specialization;
  String? intake;
  String? streamId;
  String? wishlistStatus;
  String? counselling;
  String? image;

  factory GetUniversityData.fromJson(Map<String, dynamic> json) => GetUniversityData(
    id: json["id"],
    applicationNo: json["application_no"],
    universityImage: json["university_image"],
    applicationType: json["application_type"],
    institutionName: json["institution_name"],
    address: json["address"],
    city: json["city"],
    district: json["district"],
    pincode: json["pincode"],
    state: json["state"],
    region: json["region"],
    instType: json["inst_type"],
    program: json["program"],
    course: json["course"],
    freeCounselling: json["free_counselling"],
    level: json["level"],
    specialization: json["specialization"],
    intake: json["intake"],
    streamId: json["stream_id"],
    wishlistStatus: json["wishlist_status"],
    counselling: json["counselling"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "application_no": applicationNo,
    "university_image": universityImage,
    "application_type": applicationType,
    "institution_name": institutionName,
    "address": address,
    "city": city,
    "district": district,
    "pincode": pincode,
    "state": state,
    "region": region,
    "inst_type": instType,
    "program": program,
    "course": course,
    "free_counselling": freeCounselling,
    "level": level,
    "specialization": specialization,
    "intake": intake,
    "stream_id": streamId,
    "wishlist_status": wishlistStatus,
    "counselling": counselling,
    "image": image,
  };
}
