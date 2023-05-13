import 'dart:developer';

import 'package:campus_coach/controller/coach/coach_controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class AcceptedAppointment extends StatelessWidget {
  const AcceptedAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CoachController coachController = Get.put(CoachController());
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.backgroundColor,
          child: Obx(
            () => coachController.coachAcceptedBooing.value.data?.length != 0
                ? ListView.builder(
                    padding: paddingSymmetric(vertical: 1.h),
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        coachController.coachAcceptedBooing.value.data?.length,
                    itemBuilder: (context, index) {
                      var response = coachController
                          .coachAcceptedBooing.value.data?[index];
                      return ListView(
                        shrinkWrap: true,
                        padding: paddingSymmetric(vertical: 1.w),
                        physics: ClampingScrollPhysics(),
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(1.w),
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.w),
                                color: Colors.white,
                              ),
                              child: Column(children: [
                                Container(
                                  margin: paddingSymmetric(
                                      horizontal: 4.w, vertical: 1.w),
                                  child: Row(children: [
                                    AppWidget.circleAvtarWidget(
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
                                    Expanded(
                                      child: Container(
                                          margin: paddingSymmetric(
                                              horizontal: 2.w, vertical: 1.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      flex: 4,
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              flex: 5,
                                                              child: Container(
                                                                child: Text(
                                                                    response?.userName ??
                                                                        '',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                    style: AppStyles
                                                                        .smallTextStyle),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  CircleAvatar(
                                                                maxRadius: 3.w,
                                                                child: Icon(
                                                                    Icons.call,
                                                                    size: 4.w,
                                                                    color: Colors
                                                                        .white),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .lightGreen,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            '₹${response?.price ?? ''}',
                                                            style: AppStyles
                                                                .smallTextStyle,
                                                          ),
                                                          Text(
                                                              '(${response?.duration.toString() ?? ''} min)',
                                                              style: AppStyles
                                                                  .extraSmallTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              smallerSizedBox,
                                              if (response?.bookingStatus !=
                                                  'Completed')
                                                Text(
                                                  'The Appointment has been scheduled for ${response?.date ?? ' '} at ${response?.timeSlot}',
                                                  style: AppStyles.smaller,
                                                ),
                                              if (response?.duration ==
                                                  'Package')
                                                Text(
                                                  'Subscribed for this packafe on ${response?.date ?? ' '},Please contact the student.',
                                                  style: AppStyles.smaller,
                                                )
                                            ],
                                          )),
                                    ),
                                  ]),
                                ),
                                response?.bookingStatus == 'Completed'
                                    ? Padding(
                                        padding: paddingSymmetric(
                                            horizontal: 4.w, vertical: 6),
                                        child: AppWidget.signInButton(
                                            onTap: () {},
                                            size: Size(double.infinity, 9.w),
                                            fontSize: 9.sp,
                                            text: AppStrings.completed,
                                            color: AppColors.lightGreen),
                                      )
                                    : Padding(
                                        padding:
                                            paddingSymmetric(horizontal: 3.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                                child: AppWidget.signInButton(
                                                    size: Size(
                                                        double.infinity, 9.w),
                                                    onTap: () => Get.toNamed(
                                                            RouteHelper
                                                                .scheduleAppointment,
                                                            arguments: [
                                                              response?.bookId
                                                            ]),
                                                    text: AppStrings.reSchedule,
                                                    fontSize: 9.sp,
                                                    color:
                                                        Colors.teal.shade600)),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Expanded(
                                                child: AppWidget.signInButton(
                                                    size: Size(
                                                        double.infinity, 9.w),
                                                    onTap: () => AppWidget
                                                        .showDialogForAppointments(
                                                            context: context,
                                                            titleText: AppStrings
                                                                .completeBookingTitle,
                                                            subText: AppStrings
                                                                .completeBookingText,
                                                            onPressed:
                                                                () async {
                                                              final DateFormat
                                                                  formatter =
                                                                  DateFormat(
                                                                      'yyyy-MM-dd');
                                                              final DateFormat
                                                                  formatter1 =
                                                                  DateFormat(
                                                                      'dd-MMM-yyyy');
                                                              String
                                                                  currentDate =
                                                                  formatter.format(
                                                                      DateTime
                                                                          .now());
                                                              var date1 = formatter1
                                                                  .parse(response
                                                                          ?.date ??
                                                                      '');
                                                              var date2 =
                                                                  formatter
                                                                      .format(
                                                                          date1);

                                                              DateTime dt1 =
                                                                  DateTime.parse(
                                                                      currentDate);
                                                              DateTime dt2 =
                                                                  DateTime.parse(
                                                                      date2);
                                                              log('Current $dt1');
                                                              log('response $dt2');
                                                              log('future ${dt1.compareTo(dt2) < 0}');
                                                              log('past ${dt1.compareTo(dt2) > 0}');
                                                              if (dt1.compareTo(
                                                                      dt2) <
                                                                  0) {
                                                                AppWidget
                                                                    .flutterToast(
                                                                        msg:
                                                                            'Ypu can only complete meeting after ${response?.date ?? ''}');
                                                              } else {
                                                                await coachController
                                                                    .completeBooking(
                                                                        orderId:
                                                                            response?.bookId.toString() ??
                                                                                '');
                                                              }
                                                            }),
                                                    text: AppStrings
                                                        .completeBooking,
                                                    fontSize: 9.sp,
                                                    color:
                                                        AppColors.lightBlue)),
                                          ],
                                        ),
                                      ),
                              ]),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(AppStrings.noAcceptedAppointment,
                        style: AppStyles.smallTextStyle),
                  ),
          ),
        ),
        Obx(
          () => coachController.isLoading.value == true
              ? AppWidget.progressIndicator()
              : Container(),
        )
      ],
    )));
  }
}
