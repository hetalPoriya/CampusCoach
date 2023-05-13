import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/controller.dart';
import '../../../utils/utils.dart';

class UniversityDetails extends StatelessWidget {
  const UniversityDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: studentMainController
                  .getSingleUniversityData?.first.freeCounselling ==
              "1"
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
          appBarString: AppStrings.universityDetails,
          child: Obx(
            () => studentMainController.isLoading.value == true
                ? AppWidget.progressIndicator()
                : ListView(
                    padding: paddingSymmetric(horizontal: 4.w, vertical: 3.h),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppWidget.circleAvtarWidget(
                            minRadius: 14.w,
                            minRadius1: 13.8.w,
                            response: studentMainController
                                .getSingleUniversityData?.first.universityImage
                                .toString(),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 2.w, bottom: 1.h),
                          //   child: CircleAvatar(
                          //     maxRadius: 12.w,
                          //     backgroundColor: Colors.black26,
                          //   ),
                          // ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    studentMainController
                                            .getSingleUniversityData
                                            ?.first
                                            .institutionName
                                            .toString() ??
                                        '',
                                    style: AppStyles.mediumTextStyle,
                                  ),
                                  smallerSizedBox,
                                  Padding(
                                      padding: EdgeInsets.only(left: 6.w),
                                      child: AppWidget.htmlWidget(
                                          text: studentMainController
                                                  .getSingleUniversityData
                                                  ?.first
                                                  .address ??
                                              '',
                                          fontSize: 10.sp))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      mediumSizedBox,
                      AppWidget.htmlWidget(
                          text: studentMainController.getSingleUniversityData
                                  ?.first.specialization ??
                              ''),
                      mediumSizedBox,
                      AppWidget.darkBlueContainer(
                        context: context,
                        titleText: AppStrings.universityType,
                        text: studentMainController
                                .getSingleUniversityData?.first.instType ??
                            '',
                      ),
                      smallSizedBox,
                      AppWidget.darkBlueContainer(
                        context: context,
                        titleText: AppStrings.educationLevelAndStream,
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentMainController.getSingleUniversityData!
                                      .first.levelName!.first.level ??
                                  '',
                              style: AppStyles.smallTextStyle,
                            ),
                            smallerSizedBox,
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: studentMainController
                                  .getSingleUniversityData!
                                  .first
                                  .levelName
                                  ?.first
                                  .streamName
                                  ?.length,
                              itemBuilder: (context, index) => Text(
                                studentMainController
                                        .getSingleUniversityData
                                        ?.first
                                        .levelName
                                        ?.first
                                        .streamName?[index] ??
                                    '',
                                style: AppStyles.extraSmallTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      smallSizedBox,
                      AppWidget.darkBlueContainer(
                        context: context,
                        titleText: AppStrings.coursesOffered,
                        text: studentMainController
                                .getSingleUniversityData!.first.course ??
                            '',
                      ),
                    ],
                  ),
          )),
    );
  }

  text({required String text}) => Text(
        text,
        style: AppStyles.extraSmallTextStyle
            .copyWith(fontWeight: FontWeight.normal),
      );
}
