import 'dart:developer';

import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/model/student/student_appointments.dart';
import 'package:campus_coach/utils/app_assets.dart';
import 'package:campus_coach/utils/app_colors.dart';
import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/utils/app_styles.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  StudentMainController studentMainController =
      Get.put(StudentMainController());

  getAppointment() async {
    await studentMainController.getStudentAppointmentApiCall();
  }

  @override
  void initState() {
    getAppointment();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBarString: AppStrings.appointmentHistory,
      child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: paddingSymmetric(horizontal: 4.w),
            child: Column(
              children: [
                smallSizedBox,
                Container(
                  padding: paddingAll(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.w),
                    color: Colors.blueGrey.shade50,
                    border: Border.all(color: Colors.black),
                  ),
                  child: TabBar(
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: AppStyles.extraSmallTextStyle,
                      labelStyle: AppStyles.extraSmallTextStyle,
                      onTap: (i) async {
                        log('TAB $i');
                      },
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.w),
                          color: Color(0xff2e5cb8)),
                      tabs: [
                        Tab(
                          text: AppStrings.upcomingAppointment,
                        ),
                        Tab(
                          text: AppStrings.pastAppointment,
                        ),
                      ]),
                ),
                Expanded(
                    child: Stack(
                  children: [
                    TabBarView(
                      children: [
                        Obx(
                          () => showAppointmentWidget(
                              appointmentData: studentMainController
                                  .studentUpcomingAppointment.value,
                              tabIndex: 0),
                        ),
                        Obx(
                          () => showAppointmentWidget(
                              appointmentData: studentMainController
                                  .studentPastAppointment.value,
                              tabIndex: 1),
                        )
                        // Container(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       AppStrings.noAppointmentFound,
                        //       style: AppStyles.smallTextStyle,
                        //     )),
                        // Container(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       AppStrings.noAppointmentFound,
                        //       style: AppStyles.smallTextStyle,
                        //     )),
                      ],
                    ),
                    Obx(
                      () => studentMainController.isLoading.value == true
                          ? AppWidget.progressIndicator()
                          : Container(),
                    )
                  ],
                ))
              ],
            ),
          )),
    );
  }

  showAppointmentWidget(
      {required StudentAppointments appointmentData, required int tabIndex}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: appointmentData.data?.length,
      itemBuilder: (context, index) {
        var response = appointmentData.data?[index];

        return appointmentData.data?.length != 0
            ? Container(
                margin: paddingSymmetric(vertical: 1.h),
                padding: paddingSymmetric(horizontal: 2.w, vertical: 0.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    boxShadow: [
                      BoxShadow(blurRadius: 4, color: Colors.black12)
                    ],
                    color: Colors.white),
                child: Row(children: [
                  Expanded(
                      child: AppWidget.circleAvtarWidget(
                    response: response?.coachImage ?? '',
                  )),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding:
                            paddingSymmetric(horizontal: 2.w, vertical: 1.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    response?.coachName ?? '',
                                    style: AppStyles.smallTextStyle,
                                  ),
                                ),
                                Flexible(
                                    child:
                                        Text('₹${response?.price.toString()}'))
                              ],
                            ),
                            SizedBox(height: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    response?.areaOfExpertise ?? '',
                                    style: AppStyles.extraSmallTextStyle,
                                  ),
                                ),
                                Flexible(
                                    child: Text(
                                  '(${response?.duration.toString() ?? ''} min)',
                                  style: AppStyles.extraSmallTextStyle
                                      .copyWith(fontSize: 9.sp),
                                ))
                              ],
                            ),
                            smallerSizedBox,
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Payment ${response?.paymentStatus.toString()}',
                                style: AppStyles.extraSmallTextStyle.copyWith(
                                    fontSize: 8.sp,
                                    color: response?.paymentStatus.toString() ==
                                            'Pending'
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ),

                            smallerSizedBox,
                            Text(
                              'Your Appointment has been scheduled for ${response?.date ?? ' '} at ${response?.timeSlot ?? ''}',
                              style: AppStyles.extraSmallTextStyle.copyWith(
                                  fontSize: 8.sp, fontWeight: FontWeight.w400),
                            ),
                            if (tabIndex == 1) smallerSizedBox,
                            if (tabIndex == 1)
                              Padding(
                                padding: paddingSymmetric(horizontal: 4.w),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(40.w, 8.w),
                                        maximumSize: Size(40.w, 8.w),
                                        elevation: 2.w,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.w)),
                                        backgroundColor: Colors.orange),
                                    onPressed: () => _showDialogForRating(
                                        coachId:
                                            response?.bookId.toString() ?? ''),
                                    child: Text(
                                      'Submit Feedback',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8.sp),
                                    )),
                              )
                            // maxLines: 4,
                            // style: AppStyles.extraSmallTextStyle,
                          ],
                        ),
                      ))
                ]),
              )
            : Text(
                appointmentData.errorMsg.toString(),
                style: AppStyles.smallTextStyle,
              );
      },
    );
  }

  _showDialogForRating({required String coachId}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: paddingSymmetric(horizontal: 1.w, vertical: 1.w),
          contentPadding: EdgeInsets.zero,
          elevation: 1.h,
          title: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.close),
              )),
          content: SingleChildScrollView(
              child: Padding(
            padding: paddingSymmetric(horizontal: 4.w, vertical: 1.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.campusCoachLogo,
                  height: 13.h,
                  width: 50.w,
                ),
                smallSizedBox,
                Text(''),
                smallSizedBox,
                AppWidget.textFormField(
                    prefixIcon: Icons.comment_rounded,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Enter Review',
                    controller: studentMainController.userReview.value),
                smallSizedBox,
                RatingBar(
                  initialRating: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),
                    empty: Icon(
                      Icons.star,
                      color: Colors.black26,
                    ),
                  ),
                  itemCount: 5,
                  itemSize: 4.h,
                  unratedColor: Colors.black26,
                  direction: Axis.horizontal,
                  itemPadding: EdgeInsets.zero,
                  onRatingUpdate: (double value) {
                    studentMainController.userRating.value = value;
                    studentMainController.update();
                  },
                ),
                mediumSizedBox,
                Padding(
                  padding: paddingSymmetric(horizontal: 10.w),
                  child: AppWidget.signInButton(
                      onTap: () async {
                        await studentMainController.updateFeedbackApiCall(
                          coachId: coachId,
                        );
                        Get.back();
                      },
                      text: AppStrings.submit),
                ),
                mediumSizedBox,
              ],
            ),
          )),
        );
      },
    );
  }
}
