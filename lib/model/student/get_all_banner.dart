// To parse this JSON data, do
//
//     final getAllBanner = getAllBannerFromJson(jsonString);

import 'dart:convert';

GetAllBanner getAllBannerFromJson(String str) =>
    GetAllBanner.fromJson(json.decode(str));

String getAllBannerToJson(GetAllBanner data) => json.encode(data.toJson());

class GetAllBanner {
  GetAllBanner({
    this.error,
    this.data,
    this.errorMsg,
  });

  String? error;
  List<BannerInfo>? data;
  String? errorMsg;

  factory GetAllBanner.fromJson(Map<String, dynamic> json) => GetAllBanner(
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<BannerInfo>.from(
                json["data"]!.map((x) => BannerInfo.fromJson(x))),
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

class BannerInfo {
  BannerInfo({
    this.id,
    this.title,
    this.image,
    this.bannerType,
    this.bannerTypeId,
  });

  String? id;
  String? title;
  String? image;
  String? bannerType;
  String? bannerTypeId;

  factory BannerInfo.fromJson(Map<String, dynamic> json) => BannerInfo(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        bannerType: json["banner_type"],
        bannerTypeId: json["banner_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "banner_type": bannerType,
        "banner_type_id": bannerTypeId,
      };
}
