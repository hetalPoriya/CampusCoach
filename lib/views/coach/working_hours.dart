import 'dart:developer';

import 'package:campus_coach/controller/coach/coach_controller.dart';
import 'package:campus_coach/utils/utils.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WorkingHours extends StatefulWidget {
  WorkingHours({Key? key}) : super(key: key);

  @override
  State<WorkingHours> createState() => _WorkingHoursState();
}

class _WorkingHoursState extends State<WorkingHours> {
  CoachController coachController = Get.put(CoachController());

  getTime() async {
    coachController.workingHoursList.value.data = [];
    coachController.workingHoursList.refresh();
    Future.delayed(
        Duration(milliseconds: 100), () => coachController.getWorkingHour());
  }

  @override
  void initState() {
    getTime();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
        appBarString: AppStrings.myWorkingHours,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            smallSizedBox,
            Center(
              child: Text(
                AppStrings.workingHours,
                style: AppStyles.smallTextStyle,
              ),
            ),
            smallSizedBox,
            Obx(
              () => coachController.workingHoursList.value.data?.length == 0
                  ? Center(
                      child: Text(
                      'Getting time..',
                      style: AppStyles.mediumTextStyle,
                    ))
                  : Expanded(
                      child: Stack(
                        children: [
                          ListView.builder(
                            padding: paddingSymmetric(
                                horizontal: 4.w, vertical: 2.h),
                            shrinkWrap: true,
                            itemCount: coachController
                                    .workingHoursList.value.data?.length ??
                                7,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var response = coachController
                                  .workingHoursList.value.data?[index];
                              return GestureDetector(
                                onTap: () {
                                  coachController.startTime.value = '';
                                  coachController.endTime.value = '';

                                  if (response?.flag == '1')
                                    _showTimeDialog(
                                        context: context,
                                        index: index,
                                        day: response?.day ?? '');
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: paddingSymmetric(vertical: 1.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.w),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 6,
                                              color: Colors.black26)
                                        ],
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (response?.flag == '0') {
                                              await coachController
                                                  .addWorkingDays(
                                                      day: response?.day ?? "",
                                                      index: index,
                                                      flag: "1");
                                            } else {
                                              await coachController
                                                  .addWorkingDays(
                                                      day: response?.day ?? "",
                                                      index: index,
                                                      flag: "0");
                                            }
                                          },
                                          child: CircleAvatar(
                                            minRadius: 7.w,
                                            maxRadius: 7.w,
                                            backgroundColor:
                                                response?.flag == "0"
                                                    ? Colors.grey.shade100
                                                    : Colors.orange.shade500,
                                            child: Text(
                                                response?.day
                                                        .toString()
                                                        .substring(0, 3) ??
                                                    '',
                                                style: AppStyles.smallTextStyle
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                          ),
                                        ),
                                        Spacer(flex: 2),
                                        Text(
                                            response?.flag == "0"
                                                ? AppStrings.closed
                                                : (response?.flag == "1" &&
                                                        response?.opentime
                                                                .toString()
                                                                .isEmpty ==
                                                            true)
                                                    ? AppStrings.setHours
                                                    : '${response?.opentime}-${response?.closetime}',
                                            style: AppStyles.extraSmallTextStyle
                                                .copyWith(
                                                    color: response?.flag == "0"
                                                        ? Colors.grey.shade400
                                                        : Colors.black,
                                                    fontStyle:
                                                        FontStyle.italic)),
                                        Spacer(flex: 3),
                                      ],
                                    )),
                              );
                            },
                          ),
                          if (coachController.isLoading.value == true)
                            AppWidget.progressIndicator()
                        ],
                      ),
                    ),
            ),
          ]),
        ));
  }

  _showTimeDialog(
      {required BuildContext context,
      required int index,
      required String day}) async {
    CoachController coachController = Get.put(CoachController());
    final TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      helpText:
          coachController.startTime.value.isEmpty ? 'Start Time' : 'End Time',
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!);
      },
    );

    if (pickedTime != null) {
      print(pickedTime.period.toString());
      print(pickedTime.format(context));
      if (coachController.startTime.value.isEmpty) {
        if (pickedTime.period == DayPeriod.am) {
          coachController.startTime.value = '${pickedTime.format(context)} Am';
        } else {
          coachController.startTime.value = '${pickedTime.format(context)} Pm';
        }
      } else {
        if (pickedTime.period == DayPeriod.am) {
          coachController.endTime.value = '${pickedTime.format(context)} Am';
        } else {
          coachController.endTime.value = '${pickedTime.format(context)} Pm';
        }
      }
      print(coachController.startTime.value.isEmpty);
      print(coachController.endTime.value.isEmpty);
      if (coachController.startTime.value.isEmpty ||
          coachController.endTime.value.isEmpty) {
        coachController.startTime.value.isEmpty
            ? coachController.startTime.value = pickedTime.format(context)
            : _showTimeDialog(context: context, index: index, day: day);
      } else {
        await coachController.addWorkingHours(
            openTime: coachController.startTime.value,
            closeTime: coachController.endTime.value,
            day: day);

        // coachController.workingHours[index].isClosed =
        //     '${coachController.startTime.value} - ${coachController.endTime.value}';
        // coachController.workingHours.refresh();
      }
    }
    // if (pickedTime != null) {
    //   print(pickedTime.format(context)); //output 10:51 PM
    //   // DateTime parsedTime =
    //   //     DateFormat.jm().parse(pickedTime.format(context).toString());
    //   //converting to DateTime so that we can further format on different pattern.
    //   // print(parsedTime); //output 1970-01-01 22:53:00.000
    //   // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
    //   // print(formattedTime); //output 14:59:00
    //   //DateFormat() is from intl package, you can format the time on any pattern you need.
    //
    //   // timeinput.text = formattedTime; //set the value of text field.
    // } else {
    //   AppWidgets.flutterToast(msg: "Time is not selected");
    // }
  }
}
