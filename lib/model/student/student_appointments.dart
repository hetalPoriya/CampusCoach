// To parse this JSON data, do
//
//     final stundetAppoinments = stundetAppoinmentsFromJson(jsonString);

import 'dart:convert';

StudentAppointments stundetAppoinmentsFromJson(String str) =>
    StudentAppointments.fromJson(json.decode(str));

String stundetAppoinmentsToJson(StudentAppointments data) =>
    json.encode(data.toJson());

class StudentAppointments {
  String? error;
  List<StudentAppointmentData>? data;
  String? errorMsg;

  StudentAppointments({
    this.error,
    this.data,
    this.errorMsg,
  });

  factory StudentAppointments.fromJson(Map<String, dynamic> json) =>
      StudentAppointments(
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<StudentAppointmentData>.from(
                json["data"]!.map((x) => StudentAppointmentData.fromJson(x))),
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

class StudentAppointmentData {
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

  StudentAppointmentData({
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
  });

  factory StudentAppointmentData.fromJson(Map<String, dynamic> json) =>
      StudentAppointmentData(
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
      };
}
