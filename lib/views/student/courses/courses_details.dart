import 'package:campus_coach/views/background_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/controller.dart';
import '../../../utils/utils.dart';
import '../../views.dart';

class CoursesDetails extends StatelessWidget {
  const CoursesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());
    return Scaffold(
      bottomNavigationBar:
          studentMainController.getSingleCourseData?.value.freeCounceling == "1"
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 12.w),
                      maximumSize: Size(double.infinity, 12.w),
                      elevation: 2.w,
                      backgroundColor: AppColors.darkBlue),
                  onPressed: () {},
                  child: Text(
                    AppStrings.getFreeCounselling,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ))
              : SizedBox(),
      body: BackgroundScreen(
          appBarString: AppStrings.courseDetails,
          child: ListView(
            padding: paddingSymmetric(horizontal: 3.w, vertical: 2.h),
            children: [
              Row(
                children: [
                  AppWidget.circleAvtarWidget(
                    minRadius: 14.w,
                    minRadius1: 13.8.w,
                    response: studentMainController
                            .getSingleCourseData?.value.courseImage ??
                        '',
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Flexible(
                    child: Text(
                      studentMainController
                              .getSingleCourseData?.value.courseName ??
                          '',
                      style: AppStyles.mediumTextStyle,
                    ),
                  ),
                ],
              ),
              smallSizedBox,
              AppWidget.darkBlueContainer(
                  context: context,
                  titleText: AppStrings.coachDetails,
                  text: studentMainController
                          .getSingleCourseData?.value.description ??
                      ''),
              smallSizedBox,
              AppWidget.darkBlueContainer(
                context: context,
                titleText: AppStrings.courseDescription,
                text: studentMainController
                        .getSingleCourseData?.value.courseDuration ??
                    '',
              ),
              smallSizedBox,
              AppWidget.darkBlueContainer(
                  context: context,
                  titleText: AppStrings.eligibility,
                  text: studentMainController
                          .getSingleCourseData?.value.eligibilityCriteria ??
                      ''),
              smallSizedBox,
              AppWidget.darkBlueContainer(
                  context: context,
                  titleText: AppStrings.universitiesOfferingCourse,
                  text: studentMainController
                          .getSingleCourseData?.value.universityName ??
                      ''),
            ],
          )),
    );
  }
}
