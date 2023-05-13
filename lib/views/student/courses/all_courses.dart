import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/controller.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/utils.dart';
import '../../views.dart';

class AllCourses extends StatelessWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());
    return BackgroundScreen(
        appBarString: studentMainController.isSavedCourse == 0
            ? AppStrings.myCourses
            : AppStrings.mySavedCourses,
        child: Container(
          alignment: Alignment.topCenter,
          child: Obx(
            () => studentMainController.isLoading.value == true
                ? AppWidget.progressIndicator()
                : studentMainController.getCourseData?.value.data?.length == 0
                    ? Center(
                        child: Text(
                        'No Record Found',
                        style: AppStyles.mediumTextStyle,
                      ))
                    : ListView.builder(
                        itemCount: studentMainController
                            .getCourseData?.value.data?.length,
                        padding:
                            paddingSymmetric(horizontal: 4.w, vertical: 2.h),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var response = studentMainController
                              .getCourseData?.value.data?[index];
                          return GestureDetector(
                            onTap: () {
                              studentMainController.getSingleCourseData?.value =
                                  response!;
                              Get.toNamed(RouteHelper.coursesDetails);
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
                                      response: response?.courseImage ?? '',
                                      minRadius1: 10.8.w,
                                      minRadius: 11.w),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          paddingSymmetric(horizontal: 2.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 5,
                                                child: Text(
                                                  response?.courseName ?? '',
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
                                                          .addCourseWishlist(
                                                              index: index,
                                                              courseId: response!
                                                                  .id
                                                                  .toString())
                                                      : studentMainController
                                                          .removeCourseWishlist(
                                                              index: index,
                                                              courseId: response!
                                                                  .id
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
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey.shade300,
                                                          )
                                                        ])),
                                              ))
                                            ],
                                          ),
                                          smallerSizedBox,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.timer_outlined,
                                                  color: Colors.grey,
                                                  size: 4.w),
                                              Text(
                                                response?.courseDuration ?? '',
                                                style: AppStyles
                                                    .extraSmallTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          smallerSizedBox,
                                          Text(
                                            response?.description ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.extraSmallTextStyle
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 9.sp),
                                          ),
                                        ],
                                      ),
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
