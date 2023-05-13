// To parse this JSON data, do
//
//     final getWokingHours = getWokingHoursFromJson(jsonString);

import 'dart:convert';

GetWorkingHours getWorkingHoursFromJson(String str) =>
    GetWorkingHours.fromJson(json.decode(str));

String addWorkingHoursToJson(AddWorkingHours data) => json.encode(data.toMap());

class AddWorkingHours {
  String masterId;
  String day;
  String openTime;
  String closeTime;
  String flag;

  AddWorkingHours(
      {required this.masterId,
      required this.day,
      required this.closeTime,
      required this.openTime,
      required this.flag});

  Map<String, dynamic> toMap() => {
        "master_id": masterId,
        "day": day,
        "opentime": openTime,
        "closetime": closeTime,
        "flag": flag,
      };
}

class GetWorkingHours {
  String? error;
  String? errorMsg;
  List<GetWorkingHoursData>? data;

  GetWorkingHours({
    this.error,
    this.errorMsg,
    this.data,
  });

  factory GetWorkingHours.fromJson(Map<String, dynamic> json) =>
      GetWorkingHours(
        error: json["error"],
        errorMsg: json["error_msg"],
        data: json["data"] == null
            ? []
            : List<GetWorkingHoursData>.from(
                json["data"]!.map((x) => GetWorkingHoursData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "error_msg": errorMsg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetWorkingHoursData {
  String? opentime;
  String? closetime;
  String? bOpentime;
  String? bClosetime;
  String? flag;
  String? day;

  GetWorkingHoursData({
    this.opentime,
    this.closetime,
    this.bOpentime,
    this.bClosetime,
    this.flag,
    this.day,
  });

  factory GetWorkingHoursData.fromJson(Map<String, dynamic> json) =>
      GetWorkingHoursData(
        opentime: json["opentime"],
        closetime: json["closetime"],
        bOpentime: json["b_opentime"],
        bClosetime: json["b_closetime"],
        flag: json["flag"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "opentime": opentime,
        "closetime": closetime,
        "b_opentime": bOpentime,
        "b_closetime": bClosetime,
        "flag": flag,
        "day": day,
      };
}
