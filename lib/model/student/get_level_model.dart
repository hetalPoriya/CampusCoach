// To parse this JSON data, do
//
//     final getLevelModel = getLevelModelFromJson(jsonString);

import 'dart:convert';

GetLevelModel getLevelModelFromJson(String str) =>
    GetLevelModel.fromJson(json.decode(str));

String getLevelModelToJson(GetLevelModel data) => json.encode(data.toJson());

class GetLevelModel {
  GetLevelModel({
    this.error,
    required this.data,
    this.errorMsg,
  });

  String? error;
  List<GetLevelData> data;
  String? errorMsg;

  factory GetLevelModel.fromJson(Map<String, dynamic> json) => GetLevelModel(
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<GetLevelData>.from(
                json["data"]!.map((x) => GetLevelData.fromJson(x))),
        errorMsg: json["error_msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "error_msg": errorMsg,
      };
}

class GetLevelData {
  GetLevelData({
    this.id,
    this.name,
    this.status,
    this.createdDate,
  });

  String? id;
  String? name;
  String? status;
  DateTime? createdDate;

  factory GetLevelData.fromJson(Map<String, dynamic> json) => GetLevelData(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_date": createdDate?.toIso8601String(),
      };
}
