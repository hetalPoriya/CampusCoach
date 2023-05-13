import 'dart:developer';

import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/utils/app_colors.dart';
import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/utils/app_styles.dart';
import 'package:campus_coach/utils/sharedPref_class.dart';
import 'package:campus_coach/utils/sharedPref_strings.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ScheduleAppointment extends StatefulWidget {
  const ScheduleAppointment({Key? key}) : super(key: key);

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  StudentMainController studentMainController =
      Get.put(StudentMainController());

  CoachController coachController = Get.put(CoachController());

  @override
  void initState() {
    // log("COACH ID ${Get.arguments[0]}");
    studentMainController.getTimeSlotModel.value.timeslot = [];
    studentMainController.getTimeSlotModel.refresh();
    super.initState();
  }

  // getTimeSlot() async {
  //   final DateTime now = DateTime.now();
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String formatted = formatter.format(now);
  //   log('ID ${studentMainController.getSingleCampusCoachData!.value.id.toString()}');
  //   log('Date $formatted');
  //   await studentMainController.getTimeSlotApiCall(
  //       date: formatted,
  //       masterId: studentMainController.getSingleCampusCoachData!.value.id
  //           .toString());
  // }
  //
  // @override
  // void initState() {
  //   studentMainController = Get.put(StudentMainController());
  //   getTimeSlot();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
        appBarString: AppStrings.scheduleYourAppointment,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  margin: paddingSymmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.w),
                      color: Color(0xffEFF8FD),
                      border: Border.all(color: AppColors.darkBlue, width: 1)),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: AppColors.darkBlue, // header background color
                        onPrimary: Colors.white, // header text color
                        onSurface: Colors.black, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          primary: Colors.red, // button text color
                        ),
                      ),
                    ),
                    child: CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2090),
                      onDateChanged: (DateTime value) async {
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        studentMainController.timeSlot.value = '';
                        studentMainController.formatted.value =
                            formatter.format(value);
                        studentMainController.update();
                        log('ID ${studentMainController.getSingleCampusCoachData!.value.id.toString()}');
                        log('Date ${studentMainController.formatted.value}');
                        await studentMainController.getTimeSlotApiCall(
                            date: studentMainController.formatted.value,
                            masterId: SharedPrefClass.getInt(
                                        SharedPrefStrings.isStudent) ==
                                    0
                                ? studentMainController
                                    .getSingleCampusCoachData!.value.id
                                    .toString()
                                : SharedPrefClass.getString(
                                    SharedPrefStrings.id));
                      },
                    ),
                  ),
                ),
                smallSizedBox,
                Obx(
                  () {
                    return Column(
                      children: [
                        smallSizedBox,
                        if (studentMainController
                                .getTimeSlotModel.value.timeslot?.length !=
                            0)
                          Text('Available Time Slots',
                              style: AppStyles.smallTextStyle),
                        if (studentMainController
                                .getTimeSlotModel.value.timeslot?.length !=
                            0)
                          smallSizedBox,
                        studentMainController
                                    .getTimeSlotModel.value.timeslot?.length !=
                                0
                            ? Container(
                                height: 6.h,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    padding: paddingSymmetric(horizontal: 2.w),
                                    itemCount: studentMainController
                                        .getTimeSlotModel
                                        .value
                                        .timeslot
                                        ?.length,
                                    itemBuilder: (context, index) => Obx(
                                          () => GestureDetector(
                                            onTap: () async {
                                              studentMainController.timeSlot
                                                  .value = studentMainController
                                                      .getTimeSlotModel
                                                      .value
                                                      .timeslot?[index] ??
                                                  '';
                                              studentMainController.update();
                                              log('TIME ${studentMainController.timeSlot.value}');
                                            },
                                            child: Container(
                                                margin: paddingSymmetric(
                                                    horizontal: 2.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.w),
                                                    border: Border.all(
                                                        color:
                                                            AppColors.darkBlue),
                                                    color: studentMainController
                                                                .timeSlot
                                                                .value ==
                                                            studentMainController
                                                                .getTimeSlotModel
                                                                .value
                                                                .timeslot?[index]
                                                        ? AppColors.darkBlue
                                                        : Colors.transparent),
                                                height: 4.h,
                                                width: 20.w,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  studentMainController
                                                          .getTimeSlotModel
                                                          .value
                                                          .timeslot?[index] ??
                                                      '',
                                                  style: AppStyles.smallTextStyle.copyWith(
                                                      color: studentMainController
                                                                  .timeSlot
                                                                  .value ==
                                                              studentMainController
                                                                  .getTimeSlotModel
                                                                  .value
                                                                  .timeslot?[index]
                                                          ? Colors.white
                                                          : Colors.black),
                                                )),
                                          ),
                                        )),
                              )
                            : Text('No time slots available for this date',
                                style: AppStyles.smallTextStyle),
                        largeSizedBox,
                      ],
                    );
                  },
                ),
                Padding(
                  padding: paddingSymmetric(horizontal: 10.w),
                  child: AppWidget.signInButton(
                      onTap: () async {
                        if (studentMainController.timeSlot.value.isNotEmpty) {
                          SharedPrefClass.getInt(SharedPrefStrings.isStudent) ==
                                  0
                              ? await studentMainController.saveBookingApiCall(
                                  coachId: studentMainController
                                      .getSingleCampusCoachData!.value.id
                                      .toString(),
                                  date: studentMainController.formatted.value,
                                )
                              : await coachController.reScheduleBooking(
                                  date: studentMainController.formatted.value,
                                  timeslot:
                                      studentMainController.timeSlot.value,
                                  orderId: Get.arguments[0]);
                        } else {
                          AppWidget.flutterToast(msg: 'Choose a timeslot');
                        }
                      },
                      text: AppStrings.bookAppointment),
                ),
                smallSizedBox,
              ],
            ),
            Obx(
              () => studentMainController.isLoading.value == true
                  ? AppWidget.progressIndicator()
                  : Container(),
            )
          ],
        ));
  }
}
