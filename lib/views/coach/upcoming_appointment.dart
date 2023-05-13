import 'dart:developer';

import 'package:campus_coach/controller/coach/coach_controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class UpcomingAppointment extends StatelessWidget {
  const UpcomingAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoachController coachController = Get.put(CoachController());
    return SafeArea(
        child: Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => coachController.isLoading.value == true
                ? AppWidget.progressIndicator()
                : coachController.coachUpcomingBooking.value.data?.length != 0
                    ? ListView.builder(
                        padding: paddingSymmetric(vertical: 1.w),
                        itemCount: coachController
                            .coachUpcomingBooking.value.data?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var response = coachController
                              .coachUpcomingBooking.value.data?[index];
                          return Container(
                            margin: paddingSymmetric(vertical: 1.h),
                            padding: paddingSymmetric(
                                horizontal: 2.w, vertical: 1.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4, color: Colors.black12)
                                ],
                                color: Colors.white),
                            child: Column(
                              children: [
                                Row(children: [
                                  Expanded(
                                    child: AppWidget.circleAvtarWidget(
                                        response: (response?.userImage
                                                        .toString()
                                                        .contains('.jpg') ==
                                                    true ||
                                                response?.userImage
                                                        .toString()
                                                        .contains('.jpg') ==
                                                    true)
                                            ? response?.userImage ?? ''
                                            : ''),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: paddingSymmetric(
                                            horizontal: 2.w, vertical: 1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 3,
                                                  child: Text(
                                                    response?.userName ?? '',
                                                    style: AppStyles
                                                        .smallTextStyle,
                                                  ),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                        '₹${response?.price.toString()}'))
                                              ],
                                            ),
                                            SizedBox(height: 1),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                    response?.areaOfExpertise ??
                                                        '',
                                                    style: AppStyles
                                                        .extraSmallTextStyle,
                                                  ),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  '(${response?.duration.toString() ?? ''} min)',
                                                  style: AppStyles
                                                      .extraSmallTextStyle
                                                      .copyWith(fontSize: 9.sp),
                                                ))
                                              ],
                                            ),
                                            smallerSizedBox,

                                            Text(
                                              'Your Appointment has been scheduled for ${response?.date ?? ' '} at ${response?.timeSlot ?? ''}',
                                              style: AppStyles
                                                  .extraSmallTextStyle
                                                  .copyWith(
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),

                                            // maxLines: 4,
                                            // style: AppStyles.extraSmallTextStyle,
                                          ],
                                        ),
                                      )),
                                ]),
                                smallerSizedBox,
                                Padding(
                                  padding: paddingSymmetric(horizontal: 1.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: AppWidget.signInButton(
                                              size: Size(double.infinity, 9.w),
                                              onTap: () => Get.toNamed(
                                                      RouteHelper
                                                          .scheduleAppointment,
                                                      arguments: [
                                                        response?.bookId
                                                      ]),
                                              text: AppStrings.reSchedule,
                                              fontSize: 9.sp,
                                              color: Colors.teal.shade600)),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Expanded(
                                          child: AppWidget.signInButton(
                                              size: Size(double.infinity, 9.w),
                                              onTap: () => AppWidget
                                                  .showDialogForAppointments(
                                                      context: context,
                                                      titleText: AppStrings
                                                          .rejectBooking,
                                                      subText:
                                                          AppStrings.rejectText,
                                                      onPressed: () async {
                                                        Get.back();
                                                        await coachController
                                                            .rejectBooking(
                                                                orderId: response
                                                                        ?.bookId ??
                                                                    '');
                                                      }),
                                              text: AppStrings.reject,
                                              fontSize: 9.sp,
                                              color: Colors.red)),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Expanded(
                                          child: AppWidget.signInButton(
                                              size: Size(double.infinity, 9.w),
                                              onTap: () => AppWidget
                                                  .showDialogForAppointments(
                                                      context: context,
                                                      titleText: AppStrings
                                                          .acceptBooking,
                                                      subText:
                                                          AppStrings.acceptText,
                                                      onPressed: () async {
                                                        Get.back();

                                                        await coachController
                                                            .acceptBooking(
                                                                orderId: response
                                                                        ?.bookId
                                                                        .toString() ??
                                                                    '');
                                                      }),
                                              text: AppStrings.accept,
                                              fontSize: 9.sp,
                                              color: AppColors.lightBlue)),
                                    ],
                                  ),
                                ),
                                smallerSizedBox,
                              ],
                            ),
                          );
                        })
                    : Center(
                        child: Text(AppStrings.noUpcomingAppointment,
                            style: AppStyles.smallTextStyle),
                      ),
          )),
    ));
  }
}
