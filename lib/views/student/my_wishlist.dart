import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class MyWishList extends StatelessWidget {
  MyWishList({Key? key}) : super(key: key);

  StudentMainController studentMainController =
      Get.put(StudentMainController());

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBarString: AppStrings.myWishlist,
      child: Padding(
        padding: paddingSymmetric(horizontal: 6.w),
        child: ListView(children: [
          largeSizedBox,
          Container(
            height: 18.h,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppWidget.customContainer(
                      context: context,
                      color: AppColors.containerColor1,
                      text: AppStrings.mySavedCoach,
                      onTap: () {
                        studentMainController.isSavedCoach = 1.obs;
                        studentMainController.update();
                        studentMainController.getAllCoach();
                        Get.toNamed(RouteHelper.myCareerCoach);
                      }),
                  SizedBox(
                    width: 4.w,
                  ),
                  AppWidget.customContainer(
                      context: context,
                      color: AppColors.containerColor2,
                      text: AppStrings.mySavedScholarship,
                      onTap: () {
                        studentMainController.isSavedScholarship = 1.obs;
                        studentMainController.update();
                        studentMainController.getAllScholarship();
                        Get.toNamed(RouteHelper.allScholarship);
                      }),
                ]),
          ),
          smallSizedBox,
          Container(
            height: 18.h,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppWidget.customContainer(
                      context: context,
                      color: AppColors.containerColor3,
                      text: AppStrings.mySavedUniversity,
                      onTap: () {
                        studentMainController.isSavedUniversity = 1.obs;
                        studentMainController.update();
                        studentMainController.getAllUniversity();
                        Get.toNamed(RouteHelper.allUniversity);
                      }),
                  SizedBox(
                    width: 4.w,
                  ),
                  AppWidget.customContainer(
                      context: context,
                      color: AppColors.containerColor4,
                      text: AppStrings.mySavedCourses,
                      onTap: () {
                        studentMainController.isSavedCourse = 1.obs;
                        studentMainController.update();
                        studentMainController.getAllCourse();
                        Get.toNamed(RouteHelper.allCourses);
                      }),
                ]),
          ),
          largeSizedBox,
        ]),
      ),
    );
  }
}
