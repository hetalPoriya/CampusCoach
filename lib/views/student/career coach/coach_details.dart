import 'dart:developer';

import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/model/student/all_campus_coach_model.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/controller.dart';
import '../../../utils/utils.dart';

class CoachDetails extends StatelessWidget {
  const CoachDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentMainController studentMainController =
        Get.put(StudentMainController());

    return BackgroundScreen(
        elevation: 0,
        child: Obx(() => studentMainController.isLoading.value == true
            ? AppWidget.progressIndicator()
            : Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 12.h,
                        color: AppColors.darkBlue,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 4.h, left: 6.w),
                            child: AppWidget.circleAvtarWidget(
                                minRadius: 16.w,
                                minRadius1: 15.8.w,
                                response: studentMainController
                                        .getSingleCampusCoachData
                                        ?.value
                                        .image ??
                                    ''),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7.h, left: 6.w),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    studentMainController
                                            .getSingleCampusCoachData
                                            ?.value
                                            .name ??
                                        '',
                                    style: AppStyles.smallTextStyle
                                        .copyWith(color: Colors.white),
                                  ),
                                  mediumSizedBox,
                                  Text(
                                    studentMainController
                                            .getSingleCampusCoachData
                                            ?.value
                                            .areaOfExpertise ??
                                        '',
                                    style: AppStyles.extraSmallTextStyle,
                                  ),
                                  Text(
                                    '${studentMainController.getSingleCampusCoachData?.value.experience ?? ''} years of experience',
                                    style: AppStyles.extraSmallTextStyle,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  mediumSizedBox,
                  Expanded(
                    child: ListView(
                      padding: paddingSymmetric(horizontal: 6.w),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //  padding: paddingSymmetric(horizontal: 6.w),
                          children: [
                            Text(studentMainController
                                    .getSingleCampusCoachData?.value.aboutMe ??
                                ''),
                            smallSizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttonStyle(
                                    rs:
                                        '₹ ${studentMainController.getSingleCampusCoachData?.value.price.toString() ?? ''}',
                                    timing: ' for 30 Mins',
                                    color: Colors.teal.shade400,
                                    context: context,
                                    studentMainController:
                                        studentMainController),
                                SizedBox(
                                  width: 4.w,
                                ),
                                buttonStyle(
                                    rs:
                                        '₹ ${studentMainController.getSingleCampusCoachData?.value.newSessionPrice.toString() ?? ''}',
                                    timing: ' for 60 Mins',
                                    color: Colors.deepOrangeAccent.shade100,
                                    studentMainController:
                                        studentMainController,
                                    context: context),
                              ],
                            ),
                            if (studentMainController.getSingleCampusCoachData!
                                .value.packagePrice!.isNotEmpty)
                              smallSizedBox,
                            if (studentMainController.getSingleCampusCoachData!
                                .value.packagePrice!.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  // studentMainController.duration.value = ' ';
                                  // studentMainController
                                  //     .getTimeSlotModel.value.timeslot
                                  //     ?.clear();
                                  // studentMainController.getTimeSlotModel
                                  //     .refresh();
                                  // studentMainController.price.value =
                                  //     studentMainController
                                  //         .getSingleCampusCoachData!
                                  //         .value
                                  //         .packagePrice
                                  //         .toString();
                                  // studentMainController.update();
                                  // _scheduleMeeting(context: context);
                                },
                                child: Container(
                                  height: 8.h,
                                  width: MediaQuery.of(context).size.width,
                                  padding: paddingSymmetric(
                                      horizontal: 2.w, vertical: 1.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.w),
                                      color: AppColors.lightBlue,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 2,
                                            blurRadius: 4)
                                      ]),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '₹ ${studentMainController.getSingleCampusCoachData?.value.packagePrice ?? ''}',
                                          style: AppStyles.smallTextStyle
                                              .copyWith(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          studentMainController
                                                  .getSingleCampusCoachData
                                                  ?.value
                                                  .packageDesc ??
                                              '',
                                          style: AppStyles.smallTextStyle
                                              .copyWith(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ]),
                                ),
                              ),
                            mediumSizedBox,
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: double.parse(studentMainController
                                      .getSingleCampusCoachData!.value.rating
                                      .toString()),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 2,
                                  ),
                                  itemCount: 5,
                                  itemSize: 6.w,
                                  unratedColor: Colors.black26,
                                  direction: Axis.horizontal,
                                  itemPadding: EdgeInsets.zero,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  studentMainController.getSingleCampusCoachData
                                          ?.value.rating
                                          .toString() ??
                                      '',
                                  style: AppStyles.extraSmallTextStyle
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Text(
                                '${studentMainController.getSingleCampusCoachData?.value.reviewcount} student review(s)',
                                style: AppStyles.smallTextStyle
                                    .copyWith(color: Colors.black)),
                            // mediumSizedBox,
                            // AppWidget.darkBlueContainer(
                            //     titleText: 'Rate Us',
                            //     widget: Column(children: [
                            //       RatingBar(
                            //         initialRating: studentMainController
                            //                     .getSingleCampusCoachData!
                            //                     .value
                            //                     .ratingUser
                            //                     .toString() ==
                            //                 0
                            //             ? 0
                            //             : double.parse(studentMainController
                            //                 .getSingleCampusCoachData!
                            //                 .value
                            //                 .ratingUser
                            //                 .toString()),
                            //         ratingWidget: RatingWidget(
                            //           full: Icon(
                            //             Icons.star,
                            //             color: Colors.amber,
                            //             size: 2,
                            //           ),
                            //           half: Icon(
                            //             Icons.star_half,
                            //             color: Colors.amber,
                            //             size: 2,
                            //           ),
                            //           empty: Icon(
                            //             Icons.star,
                            //             color: Colors.black26,
                            //             size: 2,
                            //           ),
                            //         ),
                            //         itemCount: 5,
                            //         itemSize: 6.w,
                            //         unratedColor: Colors.black26,
                            //         direction: Axis.horizontal,
                            //         itemPadding: EdgeInsets.zero,
                            //         onRatingUpdate: (double value) {},
                            //       ),
                            //       smallerSizedBox,
                            //       AppWidget.textFormField(
                            //         prefixIcon: Icons.comment_rounded,
                            //         contentPadding: EdgeInsets.zero,
                            //         hintText: 'Tell us your comment',
                            //       ),
                            //       smallSizedBox,
                            //       AppWidget.signInButton(
                            //           onTap: () {
                            //             if (studentMainController
                            //                     .getSingleCampusCoachData
                            //                     ?.value
                            //                     .bookingId ==
                            //                 '0') {
                            //               log('BOOKING ${studentMainController.getSingleCampusCoachData?.value.bookingId}');
                            //               AppWidget.flutterToast(
                            //                   msg:
                            //                       'Please first book your appointment');
                            //               studentMainController
                            //                   .getTimeSlotModel.value.timeslot
                            //                   ?.clear();
                            //               studentMainController.getTimeSlotModel
                            //                   .refresh();
                            //               _openDialogForMeetingTiming(
                            //                   context: context,
                            //                   price: studentMainController
                            //                       .getSingleCampusCoachData!
                            //                       .value
                            //                       .packagePrice);
                            //             } else {}
                            //           },
                            //           text: AppStrings.submit)
                            //     ]),
                            //     context: context),
                            mediumSizedBox,
                            Text('Student\'s reviews',
                                style: AppStyles.smallTextStyle),
                            smallSizedBox,
                            studentMainController.fetchReviewData!.length == 0
                                ? Center(
                                    child: Text(
                                      AppStrings.noStudentReview,
                                      style: AppStyles.smallTextStyle
                                          .copyWith(color: Colors.grey),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: studentMainController
                                        .fetchReviewData?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 10.h,
                                        padding: paddingSymmetric(
                                            horizontal: 2.w, vertical: 1.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2.w),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 2,
                                                  blurRadius: 4)
                                            ]),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  AppWidget.circleAvtarWidget(
                                                      minRadius: 5.w,
                                                      minRadius1: 4.8.w,
                                                      response:
                                                          studentMainController
                                                              .fetchReviewData?[
                                                                  index]
                                                              .userImage
                                                              .toString()),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Text(
                                                    studentMainController
                                                            .fetchReviewData?[
                                                                index]
                                                            .userName ??
                                                        '',
                                                    style: AppStyles
                                                        .smallTextStyle,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                              Text(
                                                studentMainController
                                                        .fetchReviewData?[index]
                                                        .review ??
                                                    '',
                                                style: AppStyles.smallTextStyle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ]),
                                      );
                                    },
                                  ),
                            smallSizedBox,
                            Padding(
                              padding: paddingSymmetric(horizontal: 5.w),
                              child: AppWidget.signInButton(
                                  onTap: () => _openDialogForMeetingTiming(
                                      context: context,
                                      controller: studentMainController,
                                      price: studentMainController
                                          .getSingleCampusCoachData!
                                          .value
                                          .packagePrice,
                                      studentMainController:
                                          studentMainController
                                              .getSingleCampusCoachData?.value),
                                  text: AppStrings.scheduleAppointment),
                            ),
                            mediumSizedBox
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        appBarString: AppStrings.coachDetails);
  }

  _openDialogForMeetingTiming(
      {required BuildContext context,
      String? price,
      CampusCoachData? studentMainController,
      required StudentMainController controller}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text(AppStrings.meetingDuration, style: AppStyles.smallTextStyle),
          content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.duration.value = '60';
                    controller.price.value =
                        studentMainController?.newSessionPrice.toString() ?? '';
                    Get.back();

                    Get.toNamed(RouteHelper.scheduleAppointment);
                  },
                  child: Text('60 min',
                      style: AppStyles.smallTextStyle
                          .copyWith(fontWeight: FontWeight.normal)),
                ),
                smallSizedBox,
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.duration.value = '30';
                    controller.price.value =
                        studentMainController?.price.toString() ?? '';
                    Get.toNamed(RouteHelper.scheduleAppointment);
                  },
                  child: Text('30 min',
                      style: AppStyles.smallTextStyle
                          .copyWith(fontWeight: FontWeight.normal)),
                )

                // if (price.toString().isNotEmpty) smallSizedBox,
                // if (price.toString().isNotEmpty) text(text: 'Package')
              ]),
        );
      },
    );
  }

  _scheduleMeeting({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppStrings.sureScheduleAppointment,
              style: AppStyles.smallTextStyle),
          actionsPadding: paddingSymmetric(vertical: 2.h),
          actions: [
            GestureDetector(
                onTap: () => Get.back(),
                child: Text('NO', style: AppStyles.smallTextStyle)),
            SizedBox(
              width: 4.w,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed(RouteHelper.scheduleAppointment);
                },
                child: Text('YES', style: AppStyles.smallTextStyle)),
            SizedBox(
              width: 4.w,
            ),
          ],
        );
      },
    );
  }

  // text({required String text}) => GestureDetector(
  //       onTap: () {
  //         Get.back();
  //
  //         Get.toNamed(RouteHelper.scheduleAppointment);
  //       },
  //       child: Text(text,
  //           style: AppStyles.smallTextStyle
  //               .copyWith(fontWeight: FontWeight.normal)),
  //     );

  buttonStyle(
      {Color? color,
      required String rs,
      required String timing,
      required BuildContext context,
      required StudentMainController studentMainController}) {
    return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color, maximumSize: Size(50.w, 8.h)),
          onPressed: () {
            studentMainController.duration.value =
                timing.toString().substring(5, 7);
            studentMainController.price.value = rs;
            studentMainController.update();
            _scheduleMeeting(context: context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(rs,
                  style:
                      AppStyles.smallTextStyle.copyWith(color: Colors.white)),
              Text(timing,
                  style:
                      AppStyles.smallTextStyle.copyWith(color: Colors.white)),
            ],
          )),
    );
  }
}
