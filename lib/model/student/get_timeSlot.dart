// To parse this JSON data, do
//
//     final getTimeSlotModel = getTimeSlotModelFromJson(jsonString);

import 'dart:convert';

GetTimeSlotModel getTimeSlotModelFromJson(String str) =>
    GetTimeSlotModel.fromJson(json.decode(str));

String getTimeSlotModelToJson(GetTimeSlotBody data) =>
    json.encode(data.toMap());

class GetTimeSlotBody {
  String masterId;
  String? hourApi;
  String date;

  GetTimeSlotBody({
    required this.masterId,
    required this.date,
    this.hourApi,
  });

  Map<String, dynamic> toMap() => {
        "master_id": masterId,
        "hourapi": hourApi,
        "date": date,
      };
}

class GetTimeSlotModel {
  String? error;
  String? errorMsg;
  List<String>? timeslot;

  GetTimeSlotModel({
    this.error,
    this.errorMsg,
    this.timeslot,
  });

  factory GetTimeSlotModel.fromJson(Map<String, dynamic> json) =>
      GetTimeSlotModel(
        error: json["error"],
        errorMsg: json["error_msg"],
        timeslot: json["timeslot"] == null
            ? []
            : List<String>.from(json["timeslot"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "error_msg": errorMsg,
        "timeslot":
            timeslot == null ? [] : List<dynamic>.from(timeslot!.map((x) => x)),
      };
}
