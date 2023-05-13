// To parse this JSON data, do
//
//     final getCourseModel = getCourseModelFromJson(jsonString);

import 'dart:convert';

GetCourseModel getCourseModelFromJson(String str) => GetCourseModel.fromJson(json.decode(str));

String getCourseModelToJson(GetCourseModel data) => json.encode(data.toJson());

class GetCourseModel {
  GetCourseModel({
    this.error,
    this.data,
    this.errorMsg,
  });

  String? error;
  List<GetCourseData>? data;
  String? errorMsg;

  factory GetCourseModel.fromJson(Map<String, dynamic> json) => GetCourseModel(
    error: json["error"],
    data: json["data"] == null ? [] : List<GetCourseData>.from(json["data"]!.map((x) => GetCourseData.fromJson(x))),
    errorMsg: json["error_msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "error_msg": errorMsg,
  };
}

class GetCourseData {
  GetCourseData({
    this.id,
    this.courseName,
    this.courseImage,
    this.description,
    this.eligibilityCriteria,
    this.universityName,
    this.universityId,
    this.courseDuration,
    this.poweredBy,
    this.streamId,
    this.levelId,
    this.createdDate,
    this.wishlistStatus,
    this.freeCounceling,
    this.freeCounsellingUniversity,
  });

  String? id;
  String? courseName;
  String? courseImage;
  String? description;
  String? eligibilityCriteria;
  String? universityName;
  String? universityId;
  String? courseDuration;
  String? poweredBy;
  String? streamId;
  String? levelId;
  DateTime? createdDate;
  String? wishlistStatus;
  String? freeCounceling;
  String? freeCounsellingUniversity;

  factory GetCourseData.fromJson(Map<String, dynamic> json) => GetCourseData(
    id: json["id"],
    courseName: json["course_name"],
    courseImage: json["course_image"],
    description: json["description"],
    eligibilityCriteria: json["eligibility_criteria"],
    universityName: json["university_name"],
    universityId: json["university_id"],
    courseDuration: json["course_duration"],
    poweredBy: json["powered_by"],
    streamId: json["stream_id"],
    levelId: json["level_id"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    wishlistStatus: json["wishlist_status"],
    freeCounceling: json["free_counceling"],
    freeCounsellingUniversity: json["free_counselling_university"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_name": courseName,
    "course_image": courseImage,
    "description": description,
    "eligibility_criteria": eligibilityCriteria,
    "university_name": universityName,
    "university_id": universityId,
    "course_duration": courseDuration,
    "powered_by": poweredBy,
    "stream_id": streamId,
    "level_id": levelId,
    "created_date": createdDate?.toIso8601String(),
    "wishlist_status": wishlistStatus,
    "free_counceling": freeCounceling,
    "free_counselling_university": freeCounsellingUniversity,
  };
}
