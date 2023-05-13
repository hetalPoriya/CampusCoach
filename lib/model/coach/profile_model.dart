import 'dart:convert';

String profileBodyToJson(CoachProfileBody data) => json.encode(data.toMap());

class CoachProfileBody {
  String qualification;
  String userId;
  String price;
  String experience;
  String expertise;
  String packageEnable;
  String priceSixty;
  String youtubeUrl;
  String packageDesc;
  String packagePrice;
  String aboutMe;
  dynamic image;

  CoachProfileBody(
      {required this.qualification,
      required this.userId,
      required this.price,
      required this.experience,
      required this.expertise,
      required this.packageEnable,
      required this.priceSixty,
      required this.youtubeUrl,
      required this.packageDesc,
      required this.packagePrice,
      required this.aboutMe,
      this.image});

  Map<String, dynamic> toMap() => {
        "qualification": qualification,
        "user_id": userId,
        "price": price,
        "experience": experience,
        "expertise": expertise,
        "package_enable": packageEnable,
        "price_sixty": priceSixty,
        "youtube_url": youtubeUrl,
        "package_desc": packageDesc,
        "package_price": packagePrice,
        "about_me": aboutMe,
        "image": image
      };
}
