import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/utils/apis.dart';
import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/utils/sharedPref_class.dart';
import 'package:campus_coach/utils/sharedPref_strings.dart';
import 'package:campus_coach/views/views.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../model/model.dart';

class CoachAuthController extends GetxController {
  StudentAuthController studentAuthController =
      Get.put(StudentAuthController());
  RxBool isLoading = false.obs;
  Dio dio = Dio();
  //image

  RxBool packageEnable = false.obs;

  Rx<CoachLogin> coachLogin = CoachLogin().obs;
  final emailCon = TextEditingController().obs;
  final passCon = TextEditingController().obs;
  final nameCon = TextEditingController().obs;
  final phoneNumberCon = TextEditingController().obs;
  final videoUrlCon = TextEditingController().obs;
  final aboutMeCon = TextEditingController().obs;
  final areaOfExpertiseCon = TextEditingController().obs;
  final experienceCon = TextEditingController().obs;
  final price30Con = TextEditingController().obs;
  final price60Con = TextEditingController().obs;
  final packagePriceCon = TextEditingController().obs;
  final aboutPackageCon = TextEditingController().obs;
  RxString imageCon = ''.obs;

  final accountHolderNameCon = TextEditingController().obs;
  final accountNumberCon = TextEditingController().obs;
  final bankNameCon = TextEditingController().obs;
  final ifscCodeCon = TextEditingController().obs;

  //CoachSignUp
  coachSignUpApiCall() async {
    try {
      studentAuthController.isLoading(true);
      CoachSignUpBody coachSignUpBody = CoachSignUpBody(
          email: studentAuthController.emailCon.value.text,
          fullName: studentAuthController.nameCon.value.text,
          mobileNumber: studentAuthController.phoneNumberCon.value.text,
          password: studentAuthController.passCon.value.text);

      var response = await NetworkHandler.postAPi(
          body: coachSignUpBody.toMap(), endpoint: Apis.coachSignUp);
      log('signUpResponse ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        CoachLogin coachLogin = coachLoginFromJson(response);
        SharedPrefClass.setString(
            SharedPrefStrings.id, coachLogin.data!.id.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.email, coachLogin.data!.email.toString());
        SharedPrefClass.setString(SharedPrefStrings.password,
            coachLogin.data!.orgPassword.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.name, coachLogin.data!.name.toString());
        SharedPrefClass.setBool(SharedPrefStrings.isLogin, true);
        SharedPrefClass.setString(
            SharedPrefStrings.userInfo, json.encode(response.toString()));

        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = coachLoginFromJson(json.decode(userInfo));

        log('Id ${coachLogin.data!.id.toString()}');
        Get.offNamedUntil(RouteHelper.coachMainPage, (route) => false);
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      studentAuthController.isLoading(false);
    }
  }

  //CoachLogin
  coachLoginApiCall() async {
    try {
      studentAuthController.isLoading(true);
      CoachLoginBody coachLoginBody = CoachLoginBody(
          email: studentAuthController.emailCon.value.text,
          password: studentAuthController.passCon.value.text);

      var response = await NetworkHandler.postAPi(
          body: coachLoginBody.toMap(), endpoint: Apis.coachLogin);

      log('LoginResponse ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
      if (data[AppStrings.error] == '1') {
        CoachLogin coachLogin = coachLoginFromJson(response);
        SharedPrefClass.setString(
            SharedPrefStrings.id, coachLogin.data!.id.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.email, coachLogin.data!.email.toString());
        SharedPrefClass.setString(SharedPrefStrings.password,
            coachLogin.data!.orgPassword.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.name, coachLogin.data!.name.toString());
        SharedPrefClass.setBool(SharedPrefStrings.isLogin, true);
        SharedPrefClass.setString(
            SharedPrefStrings.userInfo, json.encode(response.toString()));
        getCoachProfile();
        // String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
        // StudentLogin stud = coachLoginFromJson(json.decode(userInfo));

        log('Id ${coachLogin.data!.id.toString()}');
        Get.offNamedUntil(RouteHelper.coachMainPage, (route) => false);
      }
    } on DioError catch (e) {
      log(e.toString());
    } finally {
      studentAuthController.isLoading(false);
    }
  }

  getCoachProfile() {
    isLoading(true);
    String userInfo = SharedPrefClass.getString(SharedPrefStrings.userInfo);
    if (userInfo.isNotEmpty) {
      coachLogin.value = coachLoginFromJson(json.decode(userInfo));
      emailCon.value.text = coachLogin.value.data!.email.toString();
      nameCon.value.text = coachLogin.value.data!.name.toString();
      phoneNumberCon.value.text = coachLogin.value.data!.mobileNo.toString();
      videoUrlCon.value.text = coachLogin.value.data?.youtubeVideo ?? ' ';
      aboutMeCon.value.text = coachLogin.value.data!.aboutMe.toString();
      areaOfExpertiseCon.value.text =
          coachLogin.value.data!.areaOfExpertise.toString();
      experienceCon.value.text = coachLogin.value.data!.experience.toString();
      price30Con.value.text = coachLogin.value.data!.price.toString();
      price60Con.value.text = coachLogin.value.data!.newSessionPrice.toString();
      packagePriceCon.value.text =
          coachLogin.value.data!.packagePrice.toString();
      aboutPackageCon.value.text =
          coachLogin.value.data!.packageDesc.toString();
      packageEnable.value =
          coachLogin.value.data?.packageEnable.toString() == 'yes'
              ? true
              : false;
      imageCon.value = coachLogin.value.data!.image.toString();
      accountHolderNameCon.value.text =
          coachLogin.value.data!.accountHolderName.toString();
      accountNumberCon.value.text =
          coachLogin.value.data!.accountNumber.toString();
      bankNameCon.value.text = coachLogin.value.data!.bankName.toString();
      ifscCodeCon.value.text = coachLogin.value.data!.ifscCode.toString();
      update();

      log('CoachInfo ${coachLogin.value.data?.name}');
    }
    isLoading(false);
  }

  coachUpdateProfileApiCall({File? pickedImage}) async {
    try {
      isLoading(true);
      log('${pickedImage?.path}');
      CoachProfileBody coachProfileBody = CoachProfileBody(
        qualification: ' ',
        youtubeUrl: videoUrlCon.value.text,
        userId: SharedPrefClass.getString(SharedPrefStrings.id),
        priceSixty: price60Con.value.text,
        price: price30Con.value.text,
        packagePrice: packagePriceCon.value.text,
        packageEnable: packageEnable.value == true ? 'yes' : 'false',
        experience: experienceCon.value.text,
        expertise: areaOfExpertiseCon.value.text,
        packageDesc: aboutPackageCon.value.text,
        aboutMe: aboutMeCon.value.text,
        image: (pickedImage?.path != null)
            ? await MultipartFile.fromFile(pickedImage!.path,
                filename: pickedImage.path.split('/').last)
            : imageCon.value.toString(),
      );

      var response = await NetworkHandler.postAPi(
          body: coachProfileBody.toMap(), endpoint: Apis.coachUpdateProfile);
      log('CoachUpdateProfile ${response}');
      var data = jsonDecode(response);
      AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);

      if (data[AppStrings.error] == '1') {
        CoachLogin coachLogin = coachLoginFromJson(response);
        imageCon.value = coachLogin.data!.image.toString();
        SharedPrefClass.setString(
            SharedPrefStrings.userInfo, json.encode(response.toString()));
      } else {
        AppWidget.flutterToast(msg: 'Please add you experience And expertise');
      }
    } on DioError catch (e) {
      log('ERROR ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getCoachProfile();
    super.onInit();
  }
}
