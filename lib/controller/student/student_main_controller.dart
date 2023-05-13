import 'dart:convert';
import 'dart:developer';

import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/model/model.dart';
import 'package:campus_coach/model/student/get_timeSlot.dart';
import 'package:campus_coach/model/student/student_appointments.dart';
import 'package:campus_coach/views/views.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/utils.dart';
import '../controller.dart';

class StudentMainController extends GetxController {
  //display dialog according to level
  RxInt indexForDialog = 0.obs;

  RxBool isLoading = false.obs;

  //endpoint for level and stream api
  RxString endPointForLevel = ''.obs;
  RxString endPointForStream = ''.obs;

  //store data of apis
  Rx<GetLevelModel> getLevel = GetLevelModel(data: []).obs;
  Rx<GetLevelModel> getStream = GetLevelModel(data: []).obs;
  Rx<GetLevelModel> getRegion = GetLevelModel(data: []).obs;

  //store radio value
  RxString radioGroupValue = ''.obs;

  //for store level id
  RxString levelId = ''.obs;
  RxString streamId = ''.obs;
  RxString regionId = ''.obs;
  RxString zoneName = ''.obs;

  //scholarship
  //List<GetScholarshipData>? getScholarshipData = <GetScholarshipData>[].obs;
  Rx<GetScholarshipModel>? getScholarshipData = GetScholarshipModel().obs;
  Rx<GetScholarshipData>? getSingleScholarshipData = GetScholarshipData().obs;

  //university
  Rx<GetUniversityModel>? getUniversityData = GetUniversityModel().obs;
  List<UniversityDetailsData>? getSingleUniversityData =
      <UniversityDetailsData>[].obs;

  //course
  Rx<GetCourseModel>? getCourseData = GetCourseModel().obs;
  Rx<GetCourseData>? getSingleCourseData = GetCourseData().obs;

  //coach
  Rx<AllCampusCoachModel>? allCampusCoachModel = AllCampusCoachModel().obs;
  Rx<CampusCoachData>? getSingleCampusCoachData = CampusCoachData().obs;

  RxString duration = ''.obs;
  RxString price = ''.obs;
  RxString formatted = ''.obs;
  RxString timeSlot = ''.obs;

  //review
  List<FetchReviewData>? fetchReviewData = <FetchReviewData>[].obs;

  //to check which data display saved user data to all data (0 = all, 1= saved data)
  RxInt isSavedCoach = 0.obs;
  RxInt isSavedCourse = 0.obs;
  RxInt isSavedUniversity = 0.obs;
  RxInt isSavedScholarship = 0.obs;

  //get Time Slot
  Rx<GetTimeSlotModel> getTimeSlotModel = GetTimeSlotModel().obs;

  //get student appointment
  Rx<StudentAppointments> studentUpcomingAppointment =
      StudentAppointments().obs;
  Rx<StudentAppointments> studentPastAppointment = StudentAppointments().obs;
  RxInt tabIndexForAppointment = 0.obs;

  RxDouble userRating = 0.0.obs;
  final userReview = TextEditingController().obs;

  //level api call
  getLevelApiCall() async {
    try {
      radioGroupValue = ''.obs;
      isLoading(true);
      var response =
          await NetworkHandler.getApi(endpoint: endPointForLevel.value);
      log('GetLevel ${response}');
      var data = jsonDecode(response);
      if (data[AppStrings.error] == '1') {
        getLevel.value = getLevelModelFromJson(response);
        update();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //stream api call
  getStreamApiCall() async {
    try {
      radioGroupValue = ''.obs;
      isLoading(true);
      var response =
          await NetworkHandler.getApi(endpoint: endPointForStream.value);
      log('GetStream ${response}');
      var data = jsonDecode(response);
      if (data[AppStrings.error] == '1') {
        getStream.value = getLevelModelFromJson(response);
        update();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //region api call
  getZoneApiCall() async {
    try {
      radioGroupValue = ''.obs;
      isLoading(true);
      var response = await NetworkHandler.getApi(endpoint: Apis.getAllZone);
      log('GetZone ${response}');
      var data = jsonDecode(response);
      if (data[AppStrings.error] == '1') {
        getRegion.value = getLevelModelFromJson(response);
        update();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //scholarship
  getAllScholarship({String? collegeId}) async {
    try {
      radioGroupValue = ''.obs;
      isLoading(true);
      String userId = SharedPrefClass.getString(SharedPrefStrings.id);
      log('Api ${Apis.getAllScholarship}?user_id=$userId&id=${collegeId ?? ''}&stream=${streamId}&level=${levelId}');
      var response = isSavedScholarship == 0
          ? await NetworkHandler.getApi(
              endpoint:
                  '${Apis.getAllScholarship}?user_id=$userId&id=${collegeId ?? ''}&stream=${streamId}&level=${levelId}')
          : await NetworkHandler.postAPi(
              endpoint: Apis.getScholarshipWishlist,
              body: {
                  'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
                });
      log('GetScholarship ${response}');
      var data = jsonDecode(response);
      if (data[AppStrings.error] == '1') {
        GetScholarshipModel getScholarshipModel =
            getScholarshipModelFromJson(response);
        getScholarshipData?.value.data = getScholarshipModel.data;
      } else {
        getScholarshipData?.value.data = [];
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //getUniversity
  getAllUniversity({String? collegeId}) async {
    try {
      isLoading(true);

      log('Api ${Apis.getUniversities}?limit=0&zone=${regionId ?? ''}&level=${levelId}&stream=${streamId}');
      var response = isSavedUniversity == 0
          ? await NetworkHandler.getApi(
              endpoint:
                  '${Apis.getUniversities}?limit=0&zone=${regionId ?? ''}&level=${levelId}&stream=${streamId}')
          : await NetworkHandler.postAPi(endpoint: Apis.getWishlist, body: {
              'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
            });
      log('GetUniversity ${response}');
      var data = jsonDecode(response);

      if (data[AppStrings.error] == '1') {
        GetUniversityModel getUniversityModel =
            getUniversityModelFromJson(response);
        getUniversityData?.value.data = getUniversityModel.data;
      } else {
        getUniversityData?.value.data = [];
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  universityDetails({required String universityId}) async {
    try {
      isLoading(true);
      log('ID ${universityId}');
      var response = await NetworkHandler.getApi(
          endpoint: '${Apis.getUniversityDetails}?university_id=$universityId');
      log('GetUniversityDetails ${response}');
      var data = jsonDecode(response);

      if (data[AppStrings.error] == '1') {
        UniversityDetailsModel universityDetailsModel =
            universityDetailsModelFromJson(response);
        getSingleUniversityData = universityDetailsModel.data;
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //getCourse
  getAllCourse({String? collegeId}) async {
    isLoading(true);
    try {
      String userId = SharedPrefClass.getString(SharedPrefStrings.id);
      log('Api ${Apis.getAllCourse}?offset=0&limit=0&id=&stream_id=$streamId&level=$levelId&user_id=$userId');
      var response = isSavedCourse == 0
          ? await NetworkHandler.getApi(
              endpoint:
                  '${Apis.getAllCourse}?offset=0&limit=0&id=&stream_id=$streamId&level=$levelId&user_id=$userId')
          : await NetworkHandler.postAPi(
              endpoint: Apis.getCourseWishlist, body: {'user_id': userId});
      log('GetCourse ${response}');
      var data = jsonDecode(response);

      if (data[AppStrings.error] == '1') {
        GetCourseModel getCourseModel = getCourseModelFromJson(response);
        getCourseData?.value.data = getCourseModel.data;
      } else {
        getCourseData?.value.data = [];
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //getCoach
  getAllCoach({String? coachId}) async {
    isLoading(true);
    log('Coach ${isSavedCoach}');
    allCampusCoachModel?.value.data = [];
    try {
      var response = isSavedCoach == 0
          ? await NetworkHandler.getApi(
              endpoint:
                  '${Apis.getAllCampusCoach}?user_id=${SharedPrefClass.getString(SharedPrefStrings.id)}')
          : await NetworkHandler.postAPi(body: {
              'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
            }, endpoint: Apis.getMasterWishlist);
      log('GetCoach ${response}');
      var data = jsonDecode(response);

      if (data[AppStrings.error] == '1') {
        allCampusCoachModel?.value = allCampusCoachModelFromJson(response);
        log('A ${allCampusCoachModel?.value.data?.length}');
        update();
      } else {
        allCampusCoachModel?.value.data = [];
        update();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //getCoach
  fetchReview({String? coachId}) async {
    isLoading(true);
    try {
      var response = await NetworkHandler.getApi(
          endpoint: '${Apis.fetchReview}?coach_id=$coachId');
      log('GetReview ${response}');
      var data = jsonDecode(response);

      if (data[AppStrings.error] == '1') {
        FetchReviewModel fetchReviewModel =
            fetchReviewVewModelFromJson(response);
        fetchReviewData = fetchReviewModel.data!;
        update();
      } else {
        fetchReviewData = [];
        update();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //add coach wishlist
  addCoachWishlist({required String coachId, required int index}) async {
    log('CoachId ${coachId}');
    log('CoachId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'master_id': coachId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.addMasterInWishlist);
      log('MasterLike ${response}');
      var data = jsonDecode(response);
      allCampusCoachModel?.value.data?[index].wishlistStatus = '1';
      allCampusCoachModel?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  removeCoachWishlist({required String coachId, required int index}) async {
    log('CoachId ${coachId}');
    log('CoachId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'master_id': coachId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.removeMasterFromWishlist);
      log('MasterDisLike ${response}');
      var data = jsonDecode(response);
      allCampusCoachModel?.value.data?[index].wishlistStatus = '0';
      allCampusCoachModel?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //add scholarship wishlist
  addScholarshipWishlist(
      {required String scholarshipId, required int index}) async {
    log('scholarship_id ${scholarshipId}');
    log('userId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'scholarship_id': scholarshipId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.addScholarshipInWishlist);
      log('ScholarshipLike ${response}');
      var data = jsonDecode(response);
      getScholarshipData?.value.data?[index].wishlistStatus = '1';
      getScholarshipData?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  removeScholarshipWishlist(
      {required String scholarshipId, required int index}) async {
    log('scholarship_id ${scholarshipId}');
    log('userId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'scholarship_id': scholarshipId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.removeScholarshipFromWishlist);
      log('scholarshipDisLike ${response}');
      var data = jsonDecode(response);
      getScholarshipData?.value.data?[index].wishlistStatus = '0';
      getScholarshipData?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //add university wishlist
  addUniversityWishlist(
      {required String universityId, required int index}) async {
    log('universityId ${universityId}');
    log('userId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'university_id': universityId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.addWishlist);
      log('UniversityLike ${response}');
      var data = jsonDecode(response);
      getUniversityData?.value.data?[index].wishlistStatus = '1';
      getUniversityData?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  removeUniversityWishlist(
      {required String universityId, required int index}) async {
    log('universityId ${universityId}');
    log('userId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'university_id': universityId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.removeItemFromWishlist);
      log('UniversityDisLike ${response}');
      var data = jsonDecode(response);
      getUniversityData?.value.data?[index].wishlistStatus = '0';
      getUniversityData?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //add course wishlist
  addCourseWishlist({required String courseId, required int index}) async {
    log('courseId ${courseId}');
    log('userId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'course_id': courseId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.addCourseInWishlist);
      log('CourseLike ${response}');
      var data = jsonDecode(response);
      getCourseData?.value.data?[index].wishlistStatus = '1';
      getCourseData?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  removeCourseWishlist({required String courseId, required int index}) async {
    log('courseId ${courseId}');
    log('userId ${SharedPrefClass.getString(SharedPrefStrings.id)}');
    try {
      var response = await NetworkHandler.postAPi(body: {
        'course_id': courseId,
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id)
      }, endpoint: Apis.removeCourseFromWishlist);
      log('CourseDisLike ${response}');
      var data = jsonDecode(response);
      getCourseData?.value.data?[index].wishlistStatus = '0';
      getCourseData?.refresh();
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //for rating
  saveBookingApiCall({required String coachId, required String date}) async {
    try {
      isLoading(true);
      log('Coach id ${coachId}');
      log('duration ${duration.value}');
      log('date ${date}');
      log('price.value ${price.value}');
      log('timeSlot.value ${timeSlot.value}');
      SaveBookingModel saveBookingModel = SaveBookingModel(
          coachId: coachId,
          duration: duration.value,
          date: date,
          paymentId: '111',
          price: price.value,
          timeSlot: timeSlot.value,
          transactionId: ' ',
          userId: SharedPrefClass.getString(SharedPrefStrings.id));

      var response = await NetworkHandler.postAPi(
          body: saveBookingModel.toMap(), endpoint: Apis.saveBooking);

      log('SaveBooking ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      Get.back();
      if (data[AppStrings.error] == '1') {
        // Get.offNamedUntil(
        //     RouteHelper.studentMainPage, (route) => false);
      } else {}
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //update feedback
  updateFeedbackApiCall({required String coachId}) async {
    try {
      isLoading(true);
      log('Coach id ${coachId}');
      log('rating id ${userRating.value}');
      log('review id ${userReview.value.text}');

      var response = await NetworkHandler.postAPi(body: {
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id),
        'order_id': coachId,
        'rating': userRating.value,
        'review': userReview.value.text
      }, endpoint: Apis.updateFeedback);

      log('updateFeedback ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      Get.back();
      // if (data[AppStrings.error] == '1') {
      //   // Get.offNamedUntil(
      //   //     RouteHelper.studentMainPage, (route) => false);
      // } else {}
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //getTimeSlot
  getTimeSlotApiCall({
    required String date,
    required String masterId,
  }) async {
    try {
      isLoading(true);
      GetTimeSlotBody getTimeSlotBody =
          GetTimeSlotBody(date: date, masterId: masterId, hourApi: '');

      var response = await NetworkHandler.postAPi(
          body: getTimeSlotBody.toMap(), endpoint: Apis.getTimeSlot);

      log('GetTimeSlot ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        GetTimeSlotModel getTimeSlot = getTimeSlotModelFromJson(response);
        getTimeSlotModel.value.timeslot = getTimeSlot.timeslot;
        getTimeSlotModel.refresh();
      } else {
        getTimeSlotModel.value.timeslot?.clear();
        getTimeSlotModel.refresh();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //get appointment
  getStudentAppointmentApiCall() async {
    try {
      studentUpcomingAppointment.value.data = [];
      studentPastAppointment.value.data = [];
      studentUpcomingAppointment.refresh();
      studentPastAppointment.refresh();
      isLoading(true);

      var response = await NetworkHandler.getApi(
          endpoint:
              '${Apis.getUserOrder}?user_id:${SharedPrefClass.getString(SharedPrefStrings.id)}');

      log('getStudentAppointment ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        StudentAppointments studentAppoint =
            stundetAppoinmentsFromJson(response);

        for (int i = 0; i < studentAppoint.data!.length; i++) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final DateFormat formatter1 = DateFormat('dd-MM-yyyy');
          String currentDate = formatter.format(DateTime.now());
          var date1 = formatter1.parse(studentAppoint.data?[i].date ?? '');
          var date2 = formatter.format(date1);

          DateTime dt1 = DateTime.parse(currentDate);
          DateTime dt2 = DateTime.parse(date2);
          log('Current $dt1');
          log('response $dt2');
          log('future ${dt1.compareTo(dt2) < 0}');
          log('past ${dt1.compareTo(dt2) > 0}');
          if (dt1.compareTo(dt2) < 0) {
            studentUpcomingAppointment.value.data?.add(studentAppoint.data![i]);
            studentUpcomingAppointment.refresh();
            update();
          } else {
            studentPastAppointment.value.data?.add(studentAppoint.data![i]);
            studentPastAppointment.refresh();
            update();
          }
        }

        update();
      } else {
        studentUpcomingAppointment.value.data = [];
        studentPastAppointment.value.data = [];
        studentUpcomingAppointment.refresh();
        studentPastAppointment.refresh();
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
