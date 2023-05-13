import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/utils.dart';

class ScholarshipDetails extends StatelessWidget {
  ScholarshipDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());
    return BackgroundScreen(
        appBarString: AppStrings.scholarshipDetails,
        child: ListView(
          padding: paddingSymmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            Row(
              children: [
                AppWidget.circleAvtarWidget(

                  minRadius: 14.w,
                minRadius1: 13.8.w,
                response: studentMainController
                    .getSingleScholarshipData?.value.scholarshipImage,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Flexible(
                  child: Text(
                    studentMainController
                            .getSingleScholarshipData?.value.name ??
                        '',
                    style: AppStyles.mediumTextStyle,
                  ),
                ),
              ],
            ),
            smallSizedBox,
            AppWidget.darkBlueContainer(
                context: context,
                titleText: AppStrings.scholarshipDescription,
                text: studentMainController
                    .getSingleScholarshipData?.value.description ??
                    ''),
            smallSizedBox,
            AppWidget.darkBlueContainer(
                context: context,
                titleText: AppStrings.eligibilityCriteria,
                text: studentMainController
                    .getSingleScholarshipData?.value.eligibility ??
                    ''),
            smallSizedBox,
            AppWidget.darkBlueContainer(
                context: context,
                titleText: AppStrings.awardDetails,
                text:  studentMainController
                    .getSingleScholarshipData?.value.awardDetails ??
                    ''),
            smallSizedBox,
            AppWidget.darkBlueContainer(
                context: context,
                titleText: AppStrings.howToApply,
                text:   studentMainController
                    .getSingleScholarshipData?.value.howToApply ??
                    ''),
          ],
        ));
  }
}
