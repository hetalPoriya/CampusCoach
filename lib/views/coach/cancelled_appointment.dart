import 'package:campus_coach/controller/coach/coach_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';
import '../views.dart';

class CancelledAppointment extends StatelessWidget {
  const CancelledAppointment({Key? key}) : super(key: key);

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
              : coachController.coachCancelledBooking.value.data?.length != 0
                  ? ListView.builder(
                      padding: paddingSymmetric(vertical: 1.h),
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: coachController
                          .coachCancelledBooking.value.data?.length,
                      itemBuilder: (context, index) {
                        var response = coachController
                            .coachCancelledBooking.value.data?[index];
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
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AppWidget.circleAvtarWidget(
                                              response: (response?.userImage
                                                              .toString()
                                                              .contains(
                                                                  '.jpg') ==
                                                          true ||
                                                      response?.userImage
                                                              .toString()
                                                              .contains(
                                                                  '.jpg') ==
                                                          true)
                                                  ? response?.userImage ?? ''
                                                  : ''),
                                          Expanded(
                                            child: Container(
                                                margin: paddingSymmetric(
                                                    horizontal: 2.w,
                                                    vertical: 1.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
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
                                                                    child:
                                                                        Container(
                                                                      child: Text(
                                                                          response?.userName ??
                                                                              '',
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              AppStyles.smallTextStyle),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        CircleAvatar(
                                                                      maxRadius:
                                                                          3.w,
                                                                      child: Icon(
                                                                          Icons
                                                                              .call,
                                                                          size: 4
                                                                              .w,
                                                                          color:
                                                                              Colors.white),
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
                                                            alignment: Alignment
                                                                .center,
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
                                                                                FontWeight.normal)),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      AppStrings.cancelledText,
                                                      style: AppStyles.smaller
                                                          .copyWith(
                                                              color:
                                                                  Colors.red),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ]),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Text(AppStrings.noCancelledAppointment,
                          style: AppStyles.smallTextStyle),
                    ),
        ),
      ),
    ));
  }
}
