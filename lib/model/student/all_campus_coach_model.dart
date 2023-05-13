// To parse this JSON data, do
//
//     final allCampusCoachModel = allCampusCoachModelFromJson(jsonString);

import 'dart:convert';

AllCampusCoachModel allCampusCoachModelFromJson(String str) =>
    AllCampusCoachModel.fromJson(json.decode(str));

String allCampusCoachModelToJson(AllCampusCoachModel data) =>
    json.encode(data.toJson());

class AllCampusCoachModel {
  AllCampusCoachModel({
    this.error,
    this.data,
    this.timeslots,
    this.errorMsg,
  });

  String? error;
  List<CampusCoachData>? data;
  Timeslots? timeslots;
  String? errorMsg;

  factory AllCampusCoachModel.fromJson(Map<String, dynamic> json) =>
      AllCampusCoachModel(
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<CampusCoachData>.from(
                json["data"]!.map((x) => CampusCoachData.fromJson(x))),
        timeslots: json["timeslots"] == null
            ? null
            : Timeslots.fromJson(json["timeslots"]),
        errorMsg: json["error_msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "timeslots": timeslots?.toJson(),
        "error_msg": errorMsg,
      };
}

class CampusCoachData {
  CampusCoachData(
      {this.id,
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
      this.wishlistStatus,
      this.reviewcount,
      this.rating,
      this.bookingId,
      this.review,
      this.ratingUser});

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
  String? createdDate;
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
  String? wishlistStatus;
  String? reviewcount;
  dynamic rating;
  String? bookingId;
  dynamic ratingUser;
  String? review;

  factory CampusCoachData.fromJson(Map<String, dynamic> json) =>
      CampusCoachData(
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
        createdDate: json["created_date"],
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
        wishlistStatus: json["wishlist_status"],
        reviewcount: json["reviewcount"],
        rating: json["rating"],
        bookingId: json["booking_id"],
        ratingUser: json["rating_user"],
        review: json["review"],
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
        "created_date": createdDate,
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
        "wishlist_status": wishlistStatus,
        "reviewcount": reviewcount,
        "rating": rating,
        "booking_id": bookingId,
        "rating_user": ratingUser,
        "review": review,
      };
}

class Timeslots {
  Timeslots({
    this.id,
    this.startTime,
    this.endTime,
  });

  String? id;
  String? startTime;
  String? endTime;

  factory Timeslots.fromJson(Map<String, dynamic> json) => Timeslots(
        id: json["id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
      };
}
