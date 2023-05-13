// To parse this JSON data, do
//
//     final unversityDetailsModel = unversityDetailsModelFromJson(jsonString);

import 'dart:convert';

UniversityDetailsModel universityDetailsModelFromJson(String str) => UniversityDetailsModel.fromJson(json.decode(str));

String universityDetailsModelToJson(UniversityDetailsModel data) => json.encode(data.toJson());

class UniversityDetailsModel {
  UniversityDetailsModel({
    this.error,
    this.data,
    this.errorMsg,
  });

  String? error;
  List<UniversityDetailsData>? data;
  String? errorMsg;

  factory UniversityDetailsModel.fromJson(Map<String, dynamic> json) => UniversityDetailsModel(
    error: json["error"],
    data: json["data"] == null ? [] : List<UniversityDetailsData>.from(json["data"]!.map((x) => UniversityDetailsData.fromJson(x))),
    errorMsg: json["error_msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "error_msg": errorMsg,
  };
}

class UniversityDetailsData {
  UniversityDetailsData({
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
    this.stateName,
    this.cityName,
    this.zoneName,
    this.counselling,
    this.levelName,
    this.streamName,
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
  String? stateName;
  String? cityName;
  String? zoneName;
  String? counselling;
  List<LevelName>? levelName;
  String? streamName;

  factory UniversityDetailsData.fromJson(Map<String, dynamic> json) => UniversityDetailsData(
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
    stateName: json["state_name"],
    cityName: json["city_name"],
    zoneName: json["zone_name"],
    counselling: json["counselling"],
    levelName: json["level_name"] == null ? [] : List<LevelName>.from(json["level_name"]!.map((x) => LevelName.fromJson(x))),
    streamName: json["stream_name"],
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
    "state_name": stateName,
    "city_name": cityName,
    "zone_name": zoneName,
    "counselling": counselling,
    "level_name": levelName == null ? [] : List<dynamic>.from(levelName!.map((x) => x.toJson())),
    "stream_name": streamName,
  };
}

class LevelName {
  LevelName({
    this.level,
    this.streamName,
  });

  String? level;
  List<dynamic>? streamName;

  factory LevelName.fromJson(Map<String, dynamic> json) => LevelName(
    level: json["level"],
    streamName: json["stream_name"] == null ? [] : List<dynamic>.from(json["stream_name"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "stream_name": streamName == null ? [] : List<dynamic>.from(streamName!.map((x) => x)),
  };
}
