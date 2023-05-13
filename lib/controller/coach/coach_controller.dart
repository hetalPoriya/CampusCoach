import 'dart:convert';
import 'dart:developer';
import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/model/coach/coach_accepted_booking.dart';
import 'package:campus_coach/model/coach/woking_hours.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../model/model.dart';
import '../../utils/utils.dart';
import '../../views/widgets.dart';

class CoachController extends GetxController {
  CoachAuthController coachAuthController = Get.put(CoachAuthController());

  RxInt coachTabIndex = 0.obs;

  RxString startTime = ''.obs;
  RxString endTime = ''.obs;
  RxString onTapOnHours = ''.obs;

  RxBool isLoading = false.obs;

  Rx<CoachBooking> coachUpcomingBooking = CoachBooking().obs;
  Rx<CoachBooking> coachCancelledBooking = CoachBooking().obs;
  Rx<CoachAcceptedBooking> coachAcceptedBooing = CoachAcceptedBooking().obs;
  Rx<GetWorkingHours> workingHoursList = GetWorkingHours().obs;

  // RxList workingHours = <WorkingHoursModel>[
  //   WorkingHoursModel(
  //     workingDays: AppStrings.mon,
  //     isClosed: AppStrings.closed,
  //   ),
  //   WorkingHoursModel(
  //     workingDays: AppStrings.tue,
  //     isClosed: AppStrings.closed,
  //   ),
  //   WorkingHoursModel(
  //     workingDays: AppStrings.wed,
  //     isClosed: AppStrings.closed,
  //   ),
  //   WorkingHoursModel(
  //     workingDays: AppStrings.thu,
  //     isClosed: AppStrings.closed,
  //   ),
  //   WorkingHoursModel(
  //     workingDays: AppStrings.fri,
  //     isClosed: AppStrings.closed,
  //   ),
  //   WorkingHoursModel(
  //     workingDays: AppStrings.sat,
  //     isClosed: AppStrings.closed,
  //   ),
  //   WorkingHoursModel(
  //     workingDays: AppStrings.sun,
  //     isClosed: AppStrings.closed,
  //   ),
  // ].obs;

  //update bank details
  updateBankDetailsApiCall() async {
    try {
      isLoading(true);
      BankDetailsModel bankDetailsModel = BankDetailsModel(
        coachId: SharedPrefClass.getString(SharedPrefStrings.id),
        accountHolderName: coachAuthController.accountHolderNameCon.value.text,
        accountNumber: coachAuthController.accountNumberCon.value.text,
        bankName: coachAuthController.bankNameCon.value.text,
        ifscCode: coachAuthController.ifscCodeCon.value.text,
      );

      var response = await NetworkHandler.postAPi(
          body: bankDetailsModel.toMap(),
          endpoint: Apis.updateCoachBankDetails);
      log('bankDetails ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = studentLoginFromJson(json.decode(userInfo));
        log("AA ${SharedPrefClass.getString(SharedPrefStrings.email)}");
        log("AA ${SharedPrefClass.getString(SharedPrefStrings.password)}");
        CoachLoginBody coachLoginBody = CoachLoginBody(
          email: SharedPrefClass.getString(SharedPrefStrings.email),
          password: SharedPrefClass.getString(SharedPrefStrings.password),
        );
        var response = await NetworkHandler.postAPi(
            body: coachLoginBody.toMap(), endpoint: Apis.coachLogin);
        var data = jsonDecode(response);
        log("MMMMMMM ${response}");
        if (data[AppStrings.error] == '1') {
          SharedPrefClass.setString(
              SharedPrefStrings.userInfo, json.encode(response.toString()));
          coachAuthController.getCoachProfile();
        }

        Get.offNamedUntil(RouteHelper.coachMainPage, (route) => false);
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //upcoming appointment
  coachUpcomingBookingApiCall() async {
    try {
      isLoading(true);
      var response = await NetworkHandler.postAPi(
          body: {'coach_id': SharedPrefClass.getString(SharedPrefStrings.id)},
          endpoint: Apis.coachUpcomingBooking);
      log('upcomingBooking ${response}');
      var data = jsonDecode(response);
      // AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        CoachBooking coachBooking = coachBookingFromJson(response);
        coachUpcomingBooking.value.data = coachBooking.data;
        coachUpcomingBooking.refresh();
      } else {
        coachUpcomingBooking.value.data = [];
        coachUpcomingBooking.refresh();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //accepted appointment
  coachAcceptedBookingApiCall() async {
    try {
      isLoading(true);
      var response = await NetworkHandler.postAPi(body: {
        'coach_id': SharedPrefClass.getString(SharedPrefStrings.id),
      }, endpoint: Apis.getCoachOrder);
      log('acceptedBooking ${response}');
      var data = jsonDecode(response);
      // AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        CoachAcceptedBooking coachAcceptedBooking =
            coachAcceptedBookingFromJson(response);
        coachAcceptedBooing.value.data = coachAcceptedBooking.data;
        coachAcceptedBooing.refresh();
      } else {
        coachAcceptedBooing.value.data = [];
        coachAcceptedBooing.refresh();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //cancelled appointment
  coachCancelledBookingApiCall() async {
    try {
      isLoading(true);
      var response = await NetworkHandler.postAPi(body: {
        'coach_id': SharedPrefClass.getString(SharedPrefStrings.id),
      }, endpoint: Apis.coachCancelBooking);
      log('cancelledBooking ${response}');
      var data = jsonDecode(response);
      // AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        CoachBooking coachBooking = coachBookingFromJson(response);
        coachCancelledBooking.value.data = coachBooking.data;
        coachCancelledBooking.refresh();
      } else {
        coachCancelledBooking.value.data = [];
        coachCancelledBooking.refresh();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //re-schedule
  reScheduleBooking(
      {required String orderId,
      required String date,
      required String timeslot}) async {
    log('iD ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    log('iD ${orderId}');
    log('iD ${date}');
    log('iD ${timeslot}');
    try {
      isLoading(true);
      CoachAndOrderIdModel coachAndOrderIdModel = CoachAndOrderIdModel(
          coachId: SharedPrefClass.getString(SharedPrefStrings.id),
          orderId: orderId,
          date: date,
          timeSlot: timeslot);
      var response = await NetworkHandler.postAPi(
          body: coachAndOrderIdModel.toMap(), endpoint: Apis.reScheduleBooking);

      log('reScheduleBooking ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == "1") {
        await coachUpcomingBookingApiCall();
        Get.back();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //accept
  acceptBooking({required String orderId}) async {
    log('iD ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    log('iD ${orderId}');

    try {
      isLoading(true);
      CoachAndOrderIdModel coachAndOrderIdModel = CoachAndOrderIdModel(
        coachId: SharedPrefClass.getString(SharedPrefStrings.id),
        orderId: orderId,
      );
      var response = await NetworkHandler.postAPi(
          body: coachAndOrderIdModel.toMap(), endpoint: Apis.acceptBooking);

      log('acceptBooking ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      await coachUpcomingBookingApiCall();
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //reject
  rejectBooking({required String orderId}) async {
    log('iD ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    log('iD ${orderId}');

    try {
      isLoading(true);
      CoachAndOrderIdModel coachAndOrderIdModel = CoachAndOrderIdModel(
        coachId: SharedPrefClass.getString(SharedPrefStrings.id),
        orderId: orderId,
      );
      var response = await NetworkHandler.postAPi(
          body: coachAndOrderIdModel.toMap(), endpoint: Apis.rejectBooking);

      log('rejectBooking ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      await coachUpcomingBookingApiCall();
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //complete
  completeBooking({required String orderId}) async {
    log('iD ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    log('iD ${orderId}');

    try {
      isLoading(true);
      CoachAndOrderIdModel coachAndOrderIdModel = CoachAndOrderIdModel(
        coachId: SharedPrefClass.getString(SharedPrefStrings.id),
        orderId: orderId,
      );
      var response = await NetworkHandler.postAPi(
          body: coachAndOrderIdModel.toMap(), endpoint: Apis.completeBooking);

      log('completeBooking ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      await coachAcceptedBookingApiCall();
      Get.back();
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //add hours
  addWorkingHours(
      {required String openTime,
      required String closeTime,
      required String day}) async {
    log('iD ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    log('iD ${closeTime}');
    log('iD ${openTime}');
    log('iD ${day}');

    try {
      isLoading(true);
      AddWorkingHours addWorkingHours = AddWorkingHours(
          masterId: SharedPrefClass.getString(SharedPrefStrings.id),
          flag: 'time',
          closeTime: closeTime,
          openTime: openTime,
          day: day);
      var response = await NetworkHandler.postAPi(
          body: addWorkingHours.toMap(), endpoint: Apis.addTimes);

      log('addTime ${response}');
      var data = jsonDecode(response);
      if (data[AppStrings.error] == "1") {
        await getWorkingHour();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  addWorkingDays(
      {required String day, required int index, required String flag}) async {
    log('iD ${SharedPrefClass.getString(SharedPrefStrings.id)}');

    try {
      isLoading(true);

      var response = await NetworkHandler.postAPi(body: {
        "master_id": SharedPrefClass.getString(SharedPrefStrings.id),
        "change_flag": flag,
        "days": day
      }, endpoint: Apis.addWorkingDays);

      log('AddDays ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == "1") {
        workingHoursList.value.data?[index].flag = flag;
        workingHoursList.refresh();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  getWorkingHour() async {
    try {
      isLoading(true);

      var response = await NetworkHandler.postAPi(
          body: {'master_id': SharedPrefClass.getString(SharedPrefStrings.id)},
          endpoint: Apis.getWorkingHoursChange);

      log('getTime ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == "1") {
        GetWorkingHours getWorkingHours = getWorkingHoursFromJson(response);
        workingHoursList.value.data = getWorkingHours.data;
        workingHoursList.refresh();
      } else {
        workingHoursList.value.data = [];
        workingHoursList.refresh();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}

String coachAndOrderIdModelToJson(CoachAndOrderIdModel data) =>
    json.encode(data.toMap());

class CoachAndOrderIdModel {
  String coachId;
  String orderId;
  String? timeSlot;
  String? date;

  CoachAndOrderIdModel(
      {required this.coachId, required this.orderId, this.date, this.timeSlot});

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "coach_id": coachId,
        "date": date,
        "time_slot": timeSlot
      };
}
