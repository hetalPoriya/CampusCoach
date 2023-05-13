import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/utils/app_assets.dart';
import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/utils/app_styles.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/controller.dart';
import '../../views.dart';

class MyCareerCoach extends StatelessWidget {
  const MyCareerCoach({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());

    return BackgroundScreen(
      appBarString: studentMainController.isSavedCoach == 0
          ? AppStrings.myCareerCoach
          : AppStrings.mySavedCoach,
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Obx(() => studentMainController.isLoading.value == true
                  ? AppWidget.progressIndicator()
                  : studentMainController
                              .allCampusCoachModel?.value.data?.length ==
                          0
                      ? Center(
                          child: Text(
                          'No Record Found',
                          style: AppStyles.mediumTextStyle,
                        ))
                      : GridView.builder(
                          padding:
                              paddingSymmetric(horizontal: 4.w, vertical: 2.h),
                          itemCount: studentMainController
                              .allCampusCoachModel?.value.data?.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 2.w,
                                  mainAxisSpacing: 2.w,
                                  childAspectRatio:
                                      orientation == Orientation.portrait
                                          ? 2 / 3
                                          : 3 / 2),
                          itemBuilder: (context, index) {
                            var response = studentMainController
                                .allCampusCoachModel?.value.data?[index];
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    studentMainController
                                            .getSingleCampusCoachData?.value =
                                        studentMainController
                                            .allCampusCoachModel!
                                            .value
                                            .data![index];
                                    studentMainController.update();
                                    studentMainController.fetchReview(
                                        coachId: studentMainController
                                            .allCampusCoachModel!
                                            .value
                                            .data![index]
                                            .id);
                                    Get.toNamed(RouteHelper.myCoachDetails);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(2.w),
                                        color: Colors.white),
                                    margin: EdgeInsets.only(top: 10.w),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 9.h),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              response?.name ?? '',
                                              style: AppStyles.smallTextStyle,
                                            ),
                                            Text(
                                              response?.areaOfExpertise ?? '',
                                              style: AppStyles.smaller,
                                            ),
                                            Text(
                                              '${response?.experience ?? ''} year of Experience',
                                              style: AppStyles.smaller,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: RatingBarIndicator(
                                                    rating: double.parse(
                                                        response!.rating
                                                            .toString()),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 2,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 6.w,
                                                    unratedColor:
                                                        Colors.black26,
                                                    direction: Axis.horizontal,
                                                    itemPadding:
                                                        EdgeInsets.zero,
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: orientation ==
                                                            Orientation.portrait
                                                        ? 1
                                                        : 2,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        response?.wishlistStatus ==
                                                                '0'
                                                            ? studentMainController
                                                                .addCoachWishlist(
                                                                    index:
                                                                        index,
                                                                    coachId:
                                                                        response!
                                                                            .id
                                                                            .toString())
                                                            : studentMainController
                                                                .removeCoachWishlist(
                                                                    index:
                                                                        index,
                                                                    coachId:
                                                                        response!
                                                                            .id
                                                                            .toString());
                                                      },
                                                      child: Container(
                                                          height: 3.h,
                                                          padding:
                                                              paddingSymmetric(
                                                                  horizontal: 1
                                                                      .w,
                                                                  vertical: 1
                                                                      .w),
                                                          child: Image.asset(
                                                            AppAssets.heart,
                                                            color: response
                                                                        ?.wishlistStatus ==
                                                                    '1'
                                                                ? Colors.red
                                                                : Colors.white,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                )
                                                              ])),
                                                    ))
                                              ],
                                            ),
                                            Text(
                                              '${response?.reviewcount ?? ''} Review(s)',
                                              style: AppStyles.smallTextStyle,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    studentMainController
                                            .getSingleCampusCoachData?.value =
                                        studentMainController
                                            .allCampusCoachModel!
                                            .value
                                            .data![index];
                                    studentMainController.update();
                                    studentMainController.fetchReview(
                                        coachId: studentMainController
                                            .allCampusCoachModel!
                                            .value
                                            .data![index]
                                            .id);
                                    Get.toNamed(RouteHelper.myCoachDetails);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // color: Colors.blue,
                                    child: AppWidget.circleAvtarWidget(
                                        response: response?.image ?? '',
                                        minRadius: 14.w,
                                        minRadius1: 13.8.w),
                                  ),
                                ),
                              ],
                            );
                          },
                        ));
            },
          )),
    );
  }
}
