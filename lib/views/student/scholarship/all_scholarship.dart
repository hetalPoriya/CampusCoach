import 'dart:developer';

import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/utils.dart';

class AllScholarship extends StatelessWidget {
  AllScholarship({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());
    return BackgroundScreen(
        appBarString: studentMainController.isSavedScholarship == 0
            ? AppStrings.myScholarship
            : AppStrings.mySavedScholarship,
        child: Container(
          alignment: Alignment.topCenter,
          child: Obx(
            () => studentMainController.isLoading.value == true
                ? AppWidget.progressIndicator()
                : studentMainController
                            .getScholarshipData?.value.data?.length ==
                        0
                    ? Center(
                        child: Text(
                        'No Record Found',
                        style: AppStyles.mediumTextStyle,
                      ))
                    : ListView.builder(
                        itemCount: studentMainController
                            .getScholarshipData?.value.data?.length,
                        padding:
                            paddingSymmetric(horizontal: 4.w, vertical: 2.h),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var response = studentMainController
                              .getScholarshipData?.value.data?[index];
                          return GestureDetector(
                            onTap: () {
                              studentMainController
                                  .getSingleScholarshipData?.value = response!;
                              studentMainController.getSingleScholarshipData
                                  ?.refresh();

                              log("TES ${studentMainController.getSingleScholarshipData?.value.name}");
                              Get.toNamed(RouteHelper.scholarshipDetails);
                            },
                            child: Container(
                              margin: paddingSymmetric(vertical: 1.h),
                              padding: paddingSymmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.w),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 4,
                                        spreadRadius: 4,
                                        color: Colors.black12)
                                  ],
                                  color: Colors.white),
                              child: Row(children: [
                                Expanded(
                                    child: AppWidget.circleAvtarWidget(
                                  response: response?.scholarshipImage,
                                )),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              paddingSymmetric(horizontal: 2.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 5,
                                                child: Text(
                                                  response?.name ?? '',
                                                  style:
                                                      AppStyles.smallTextStyle,
                                                ),
                                              ),
                                              Flexible(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    response?.wishlistStatus ==
                                                            '0'
                                                        ? studentMainController
                                                            .addScholarshipWishlist(
                                                                index: index,
                                                                scholarshipId:
                                                                    response!.id
                                                                        .toString())
                                                        : studentMainController
                                                            .removeScholarshipWishlist(
                                                                index: index,
                                                                scholarshipId:
                                                                    response!.id
                                                                        .toString());
                                                  },
                                                  child: Container(
                                                      height: 3.h,
                                                      padding: paddingSymmetric(
                                                          horizontal: 1.w,
                                                          vertical: 1.w),
                                                      child: Image.asset(
                                                        AppAssets.heart,
                                                        color:
                                                            response?.wishlistStatus ==
                                                                    '1'
                                                                ? Colors.red
                                                                : Colors.white,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .shade300,
                                                            )
                                                          ])),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: 6.h,
                                            child: AppWidget.htmlWidget(
                                                text: response?.description ??
                                                    ''))
                                        // maxLines: 4,
                                        // style: AppStyles.extraSmallTextStyle,
                                      ],
                                    ))
                              ]),
                            ),
                          );
                        },
                      ),
          ),
        ));
  }
}
