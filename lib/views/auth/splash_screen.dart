import 'dart:async';
import 'dart:developer';
import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StudentAuthController studentAuthController =
      Get.put(StudentAuthController());
  CoachAuthController coachAuthController = Get.put(CoachAuthController());

  // getUserInfo() async {
  //   if (SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0) {
  //     await studentAuthController.getStudentProfile();
  //   } else {
  //     await coachAuthController.getCoachProfile();
  //   }
  // }

  // @override
  // void initState() {
  //   getUserInfo();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      if (SharedPrefClass.getBool(SharedPrefStrings.isLogin, false) == true) {
        if (SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0) {
          Get.offNamed(RouteHelper.studentMainPage);
        } else {
          Get.offNamed(RouteHelper.coachMainPage);
        }
      } else {
        Get.offNamed(RouteHelper.studentOrCoachSignIn);
      }
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.backgroundImage),
                  fit: BoxFit.fill)),
          child:
              Image.asset(AppAssets.campusCoachLogo, width: 50.w, height: 25.h),
        ),
      ),
    );
  }
}
