import 'dart:convert';

String saveBookingModelToJson(SaveBookingModel data) =>
    json.encode(data.toMap());

class SaveBookingModel {
  String userId;
  String coachId;
  String price;
  String date;
  String duration;
  String paymentId;
  String transactionId;
  String timeSlot;

  SaveBookingModel({
    required this.userId,
    required this.coachId,
    required this.price,
    required this.date,
    required this.duration,
    required this.paymentId,
    required this.transactionId,
    required this.timeSlot,
  });

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "coach_id": coachId,
        "price": price,
        "date": date,
        "duration": duration,
        "payment_id": paymentId,
        "transaction_id": transactionId,
        "time_slot": timeSlot,
      };
}

String updateFeedBackModelToJson(UpdateFeedBackModel data) =>
    json.encode(data.toMap());

class UpdateFeedBackModel {
  String userId;
  String orderId;
  String rating;
  String review;

  UpdateFeedBackModel({
    required this.userId,
    required this.orderId,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "order_id": orderId,
        "rating": rating,
        "review": review,
      };
}
