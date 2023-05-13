// To parse this JSON data, do
//
//     final getScholarshipModel = getScholarshipModelFromJson(jsonString);

import 'dart:convert';

GetScholarshipModel getScholarshipModelFromJson(String str) => GetScholarshipModel.fromJson(json.decode(str));

String getScholarshipModelToJson(GetScholarshipModel data) => json.encode(data.toJson());

class GetScholarshipModel {
  GetScholarshipModel({
    this.error,
    this.data,
    this.errorMsg,
  });

  String? error;
  List<GetScholarshipData>? data;
  String? errorMsg;

  factory GetScholarshipModel.fromJson(Map<String, dynamic> json) => GetScholarshipModel(
    error: json["error"],
    data: json["data"] == null ? [] : List<GetScholarshipData>.from(json["data"]!.map((x) => GetScholarshipData.fromJson(x))),
    errorMsg: json["error_msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "error_msg": errorMsg,
  };
}

class GetScholarshipData {
  GetScholarshipData({
    this.id,
    this.name,
    this.scholarshipImage,
    this.description,
    this.awardDetails,
    this.eligibility,
    this.howToApply,
    this.status,
    this.removeStatus,
    this.createdDate,
    this.streamId,
    this.level,
    this.wishlistStatus,
  });

  String? id;
  String? name;
  String? scholarshipImage;
  String? description;
  String? awardDetails;
  String? eligibility;
  String? howToApply;
  String? status;
  String? removeStatus;
  String? createdDate;
  String? streamId;
  String? level;
  String? wishlistStatus;

  factory GetScholarshipData.fromJson(Map<String, dynamic> json) => GetScholarshipData(
    id: json["id"],
    name: json["name"],
    scholarshipImage: json["scholarship_image"],
    description: json["description"],
    awardDetails: json["award_details"],
    eligibility: json["eligibility"],
    howToApply: json["how_to_apply"],
    status: json["status"],
    removeStatus: json["remove_status"],
    createdDate: json["created_date"],
    streamId: json["stream_id"],
    level: json["level"],
    wishlistStatus: json["wishlist_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "scholarship_image": scholarshipImage,
    "description": description,
    "award_details": awardDetails,
    "eligibility": eligibility,
    "how_to_apply": howToApply,
    "status": status,
    "remove_status": removeStatus,
    "created_date": createdDate,
    "stream_id": streamId,
    "level": level,
    "wishlist_status": wishlistStatus,
  };
}
