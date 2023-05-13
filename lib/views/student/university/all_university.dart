import 'dart:developer';
import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/utils.dart';
import '../../views.dart';

class AllUniversity extends StatelessWidget {
  const AllUniversity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());
    return BackgroundScreen(
        appBarString: studentMainController.isSavedUniversity == 0
            ? studentMainController.zoneName.value.toString()
            : AppStrings.mySavedUniversity,
        child: Obx(
          () => studentMainController.isLoading.value == true
              ? AppWidget.progressIndicator()
              : studentMainController.getUniversityData?.value.data?.length == 0
                  ? Center(
                      child: Text(
                      'No Record Found',
                      style: AppStyles.mediumTextStyle,
                    ))
                  : ListView.builder(
                      itemCount: studentMainController
                          .getUniversityData?.value.data?.length,
                      shrinkWrap: true,
                      padding: paddingSymmetric(horizontal: 3.w, vertical: 3.h),
                      itemBuilder: (context, index) {
                        var response = studentMainController
                            .getUniversityData?.value.data?[index];
                        return GestureDetector(
                          onTap: () {
                            log('UniVerOId ${response?.id.toString()}');
                            studentMainController.universityDetails(
                                universityId: response!.id.toString());
                            Get.toNamed(RouteHelper.universityDetails);
                          },
                          child: Container(
                            margin: paddingSymmetric(vertical: 1.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 4,
                                      blurRadius: 4),
                                ]),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        response?.wishlistStatus == '0'
                                            ? studentMainController
                                                .addUniversityWishlist(
                                                    index: index,
                                                    universityId:
                                                        response!.id.toString())
                                            : studentMainController
                                                .removeUniversityWishlist(
                                                    index: index,
                                                    universityId: response!.id
                                                        .toString());
                                      },
                                      child: Container(
                                          height: 3.h,
                                          padding: paddingSymmetric(
                                              horizontal: 1.w, vertical: 1.w),
                                          child: Image.asset(
                                            AppAssets.heart,
                                            color:
                                                response?.wishlistStatus == '1'
                                                    ? Colors.red
                                                    : Colors.white,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                )
                                              ])),
                                    ),
                                    GestureDetector(
                                      onTap: () => Share.share(
                                          'Check out Campus Coach at:\n https://play.google.com/store/apps/details?id=com.app.campusCoach'),
                                      child: Card(
                                        //shape: BoxShape.circle,
                                        elevation: 2,
                                        child: Container(
                                            margin: paddingSymmetric(
                                                horizontal: 1.w, vertical: 1.w),
                                            child: Icon(Icons.share),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle)),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 3.h, bottom: 1.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.w, right: 2.w, bottom: 2.w),
                                        child: AppWidget.circleAvtarWidget(
                                            response:
                                                response?.image.toString(),
                                            minRadius: 12.w,
                                            minRadius1: 11.8.w),
                                      ),
                                      Container(
                                        width: 60.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: paddingSymmetric(
                                                  horizontal: 2.w),
                                              child: Text(
                                                response?.institutionName
                                                        .toString() ??
                                                    '',
                                                style: AppStyles.smallTextStyle,
                                              ),
                                            ),
                                            AppWidget.htmlWidget(
                                                text: response?.address
                                                        .toString() ??
                                                    '',
                                                fontSize: 10.sp)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }
}
