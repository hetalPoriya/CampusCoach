import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/model/model.dart';
import 'package:campus_coach/utils/apis.dart';
import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/utils/sharedPref_class.dart';
import 'package:campus_coach/utils/sharedPref_strings.dart';
import 'package:campus_coach/views/views.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class StudentAuthController extends GetxController {
  RxBool isLoading = false.obs;

  final emailCon = TextEditingController().obs;
  final passCon = TextEditingController().obs;
  final oldPassCon = TextEditingController().obs;
  final newPassCon = TextEditingController().obs;
  final confirmNewPassCon = TextEditingController().obs;
  final nameCon = TextEditingController().obs;
  final phoneNumberCon = TextEditingController().obs;
  RxString imageCon = ''.obs;

  Rx<GetAllBanner> getAllBanner = GetAllBanner().obs;
  Rx<StudentLogin> studentInfo = StudentLogin().obs;
  RxBool isVisible = true.obs;
  RxBool isNewVisible = true.obs;
  RxBool isConfirmNewVisible = true.obs;
  d.Dio dio = d.Dio();

  //StudentSignUp
  studentSignUpApiCall() async {
    try {
      isLoading(true);
      StudentSignUpBody studentSignUpBody = StudentSignUpBody(
          email: emailCon.value.text,
          fullName: nameCon.value.text,
          mobileNumber: phoneNumberCon.value.text,
          password: passCon.value.text);

      var response = await NetworkHandler.postAPi(
          body: studentSignUpBody.toMap(), endpoint: Apis.studentSignUp);
      log('signUpResponse ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        StudentLogin studentLogin = studentLoginFromJson(response);
        SharedPrefClass.setString(
            SharedPrefStrings.id, studentLogin.data!.id.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.email, studentLogin.data!.emailId.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.password, studentLogin.data!.password.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.name, studentLogin.data!.firstName.toString());
        SharedPrefClass.setBool(SharedPrefStrings.isLogin, true);
        SharedPrefClass.setString(
            SharedPrefStrings.userInfo, json.encode(response.toString()));

        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = studentLoginFromJson(json.decode(userInfo));

        log('Id ${studentLogin.data!.id.toString()}');
        Get.offNamedUntil(RouteHelper.studentMainPage, (route) => false);
      }
    } on d.DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //StudentLogin
  studentLoginApiCall() async {
    try {
      isLoading(true);
      StudentLoginBody studentLoginBody = StudentLoginBody(
          email: emailCon.value.text, password: passCon.value.text);

      var response = await NetworkHandler.postAPi(
          body: studentLoginBody.toMap(), endpoint: Apis.studentLogin);

      log('LoginResponse ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        StudentLogin studentLogin = studentLoginFromJson(response);
        SharedPrefClass.setString(
            SharedPrefStrings.id, studentLogin.data!.id.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.email, studentLogin.data!.emailId.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.password, studentLogin.data!.password.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.name, studentLogin.data!.firstName.toString());
        SharedPrefClass.setBool(SharedPrefStrings.isLogin, true);
        SharedPrefClass.setString(
            SharedPrefStrings.userInfo, json.encode(response.toString()));

        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = studentLoginFromJson(json.decode(userInfo));

        log('Id ${studentLogin.data!.id.toString()}');
        Get.offNamedUntil(RouteHelper.studentMainPage, (route) => false);
      }
    } on d.DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //forgotPass
  studentForgotPassApiCall() async {
    try {
      isLoading(true);

      var response = await NetworkHandler.postAPi(
          body: {'email': emailCon.value.text.toString()},
          endpoint: SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0
              ? Apis.studentForgotPass
              : Apis.coachForgotPass);

      log('LoginResponse ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = studentLoginFromJson(json.decode(userInfo));
        Get.back();
      }
    } on d.DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  //get banner
  getAllBannerApiCall() async {
    try {
      isLoading(true);

      var response = await NetworkHandler.getApi(endpoint: Apis.getAllBanner);

      log('GetALlBanner ${response}');
      var data = jsonDecode(response);
      // AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        getAllBanner.value = getAllBannerFromJson(response);
        log(getAllBanner.value.data!.first.title.toString());
        log(getAllBanner.value.data!.length.toString());
        update();
        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = studentLoginFromJson(json.decode(userInfo));
      }
    } on d.DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  getStudentProfile() {
    String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
    log('UserInfo $userInfo');
    if (userInfo.isNotEmpty) {
      studentInfo.value = studentLoginFromJson(json.decode(userInfo));
      nameCon.value.text = studentInfo.value.data!.firstName.toString();
      emailCon.value.text = studentInfo.value.data!.emailId.toString();
      phoneNumberCon.value.text =
          studentInfo.value.data!.mobileNumber.toString();
      imageCon.value = studentInfo.value.data!.image.toString();
      update();
      log('StudentInfo ${studentInfo.value.data?.id}');
      log('StudentInfo ${studentInfo.value.data?.image}');
    }
  }

  studentUpdateProfileApiCall({File? pickedImage}) async {
    log('${pickedImage?.path}');
    try {
      isLoading(true);
      var response = await NetworkHandler.postAPi(body: {
        'name': nameCon.value.text.toString(),
        'user_id': SharedPrefClass.getString(SharedPrefStrings.id),
        if (pickedImage?.path != null)
          'image': await await MultipartFile.fromFile(pickedImage!.path,
              filename: pickedImage.path.split('/').last),
      }, endpoint: Apis.studentUpdateProfile);
      log('StudentUpdateProfile ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);

      if (data[AppStrings.error] == '1') {
        StudentLogin studentLogin = studentLoginFromJson(response);
        imageCon.value = studentLogin.data!.image.toString();
        SharedPrefClass.setString(
            SharedPrefStrings.userInfo, json.encode(response.toString()));
      }
    } on d.DioError catch (e) {
      log('ERROR ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  //UpdatePass
  studentUpdatePasswordApiCall(
      {required String oldPassword, required String newPassword}) async {
    try {
      isLoading(true);

      var response = await NetworkHandler.postAPi(
          body: {
            'user_id': SharedPrefClass.getString(SharedPrefStrings.id),
            'old_password': oldPassword,
            'password': newPassword,
          },
          endpoint: SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0
              ? Apis.updateUserPassword
              : Apis.updateCoachPassword);

      log('UpdatePassword ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = studentLoginFromJson(json.decode(userInfo));
        Get.back();
      }
    } on d.DioError catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // getStudentProfile();
    super.onInit();
  }
}
