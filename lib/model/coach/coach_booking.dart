// To parse this JSON data, do
//
//     final coachUpcomingBooking = coachUpcomingBookingFromJson(jsonString);

import 'dart:convert';

CoachBooking coachBookingFromJson(String str) =>
    CoachBooking.fromJson(json.decode(str));

String coachBookingToJson(CoachBooking data) => json.encode(data.toJson());

class CoachBooking {
  String? error;
  List<CoachBookingData>? data;
  String? errorMsg;

  CoachBooking({
    this.error,
    this.data,
    this.errorMsg,
  });

  factory CoachBooking.fromJson(Map<String, dynamic> json) => CoachBooking(
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<CoachBookingData>.from(
                json["data"]!.map((x) => CoachBookingData.fromJson(x))),
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

class CoachBookingData {
  String? id;
  String? bookId;
  String? userId;
  String? coachId;
  String? timeSlot;
  String? date;
  String? price;
  String? transactionId;
  String? paymentStatus;
  String? bookingStatus;
  DateTime? createdDate;
  String? rating;
  String? review;
  String? duration;
  String? paymentid;
  String? coachName;
  String? coachImage;
  String? areaOfExpertise;
  String? userName;
  String? userImage;
  String? mobileNumber;

  CoachBookingData({
    this.id,
    this.bookId,
    this.userId,
    this.coachId,
    this.timeSlot,
    this.date,
    this.price,
    this.transactionId,
    this.paymentStatus,
    this.bookingStatus,
    this.createdDate,
    this.rating,
    this.review,
    this.duration,
    this.paymentid,
    this.coachName,
    this.coachImage,
    this.areaOfExpertise,
    this.userName,
    this.userImage,
    this.mobileNumber,
  });

  factory CoachBookingData.fromJson(Map<String, dynamic> json) =>
      CoachBookingData(
        id: json["id"],
        bookId: json["book_id"],
        userId: json["user_id"],
        coachId: json["coach_id"],
        timeSlot: json["time_slot"],
        date: json["date"],
        price: json["price"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        bookingStatus: json["booking_status"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        rating: json["rating"],
        review: json["review"],
        duration: json["duration"],
        paymentid: json["paymentid"],
        coachName: json["coach_name"],
        coachImage: json["coach_image"],
        areaOfExpertise: json["area_of_expertise"],
        userName: json["user_name"],
        userImage: json["user_image"],
        mobileNumber: json["mobile_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "user_id": userId,
        "coach_id": coachId,
        "time_slot": timeSlot,
        "date": date,
        "price": price,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "booking_status": bookingStatus,
        "created_date": createdDate?.toIso8601String(),
        "rating": rating,
        "review": review,
        "duration": duration,
        "paymentid": paymentid,
        "coach_name": coachName,
        "coach_image": coachImage,
        "area_of_expertise": areaOfExpertise,
        "user_name": userName,
        "user_image": userImage,
        "mobile_number": mobileNumber,
      };
}
