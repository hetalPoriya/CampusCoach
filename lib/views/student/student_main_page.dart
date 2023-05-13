import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/main_drawer_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/controller.dart';
import '../../model/drawer_menu.dart';
import '../../utils/utils.dart';

class StudentMainPage extends StatefulWidget {
  StudentMainPage({Key? key}) : super(key: key);

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  final studentController = Get.put(StudentController());
  final studentMainController = Get.put(StudentMainController());

  StudentAuthController studentAuthController =
      Get.put(StudentAuthController());

  final List<DrawerMenu> drawerMenu = [
    DrawerMenu(
        text: AppStrings.myAccount,
        icon: Icons.person,
        route: RouteHelper.myAccount),
    DrawerMenu(
        text: AppStrings.appointment,
        icon: Icons.av_timer_sharp,
        route: RouteHelper.appointment),
    DrawerMenu(
        text: AppStrings.myWishlist,
        icon: Icons.star,
        route: RouteHelper.myWishList),
    DrawerMenu(text: AppStrings.logOut, icon: Icons.logout, route: ''),
  ];

  getBanner() async {
    await studentAuthController.getAllBannerApiCall();
  }

  @override
  void initState() {
    getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainDrawerScreen.advanceDrawer(
        context: context,
        drawerMenu: drawerMenu,
        child: Container(
          padding: paddingSymmetric(horizontal: 4.w, vertical: 0.h),
          child: Stack(
            children: [
              ListView(children: [
                smallSizedBox,
                Text(
                  'Hello,',
                  style: AppStyles.mediumTextStyle.copyWith(
                      fontSize: 15.sp,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
                smallerSizedBox,
                Text(
                  SharedPrefClass.getString(SharedPrefStrings.name),
                  style: AppStyles.largeTextStyle,
                ),
                mediumSizedBox,
                Obx(() {
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(2.w)),
                      child: (studentAuthController.isLoading.value == true ||
                              (studentAuthController
                                  .getAllBanner.value.data!.isEmpty))
                          ? SizedBox(
                              height: 19.h,
                              child: Image.asset(AppAssets.campusCoachLogo),
                            )
                          : ImageSlideshow(
                              height: 19.h,
                              indicatorColor: Colors.white,
                              isLoop: true,
                              autoPlayInterval: 3000,
                              indicatorRadius: 1.w,
                              children: List.generate(
                                  studentAuthController
                                      .getAllBanner.value.data!.length,
                                  (index) => Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black45,
                                            borderRadius:
                                                BorderRadius.circular(2.w),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                studentAuthController
                                                    .getAllBanner
                                                    .value
                                                    .data![index]
                                                    .image
                                                    .toString(),
                                              ),
                                              fit: BoxFit.fill,
                                            )),
                                      )),
                            ));
                }),
                smallSizedBox,
                Container(
                  height: 18.h,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppWidget.customContainer(
                            context: context,
                            color: AppColors.containerColor1,
                            text: AppStrings.myCareerCoach,
                            onTap: () {
                              studentMainController.isSavedCoach = 0.obs;
                              studentMainController.update();
                              studentMainController.getAllCoach();
                              Get.toNamed(RouteHelper.myCareerCoach);
                            }),
                        SizedBox(
                          width: 4.w,
                        ),
                        AppWidget.customContainer(
                          context: context,
                          color: AppColors.containerColor2,
                          text: AppStrings.myScholarship,
                          onTap: () {
                            studentMainController.isSavedScholarship = 0.obs;
                            studentMainController.indexForDialog.value = 0;
                            studentMainController.endPointForLevel.value =
                                Apis.getScholarshipLevel;
                            studentMainController.update();
                            _showDialogForLevel(context: context);
                          },
                        )
                      ]),
                ),
                smallSizedBox,
                Container(
                  height: 18.h,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppWidget.customContainer(
                            context: context,
                            color: AppColors.containerColor3,
                            text: AppStrings.myUniversity,
                            onTap: () {
                              studentMainController.isSavedUniversity = 0.obs;
                              studentMainController.indexForDialog.value = 1;
                              studentMainController.endPointForLevel.value =
                                  Apis.getAllZone;
                              studentMainController.update();
                              _showDialogToChooseRegion(context: context);
                            }),
                        SizedBox(
                          width: 4.w,
                        ),
                        AppWidget.customContainer(
                            context: context,
                            color: AppColors.containerColor4,
                            text: AppStrings.myCourses,
                            onTap: () {
                              studentMainController.isSavedCourse = 0.obs;
                              studentMainController.indexForDialog.value = 2;
                              studentMainController.endPointForLevel.value =
                                  Apis.getCourseLevel;
                              studentMainController.update();
                              _showDialogForLevel(context: context);
                            }),
                      ]),
                ),
                largeSizedBox,
                Center(
                  child: Text(
                    AppStrings.madeInIndia,
                    style: AppStyles.smallTextStyle,
                  ),
                ),
                smallSizedBox,
              ]),
              Obx(
                () => studentAuthController.isLoading.value == true
                    ? AppWidget.progressIndicator()
                    : Container(),
              )
            ],
          ),
        ));
  }

  _showDialogToChooseRegion({required BuildContext context}) {
    studentMainController.getZoneApiCall();
    return AppWidget.commanDialog(
        context: context,
        titleText: AppStrings.chooseRegion,
        widget: Obx(
          () => Container(
            width: double.maxFinite,
            child: studentMainController.getRegion.value.data == []
                ? Text('No record found')
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        studentMainController.getRegion.value.data.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(studentMainController
                            .getRegion.value.data[index].name
                            .toString()),
                        value: studentMainController
                            .getRegion.value.data[index].name
                            .toString(),
                        selected: false,
                        groupValue: studentMainController.radioGroupValue.value,
                        onChanged: (v) {
                          Get.back();
                          studentMainController.endPointForLevel.value =
                              Apis.getUniversityLevel;
                          studentMainController.regionId.value =
                              studentMainController
                                  .getRegion.value.data[index].id
                                  .toString();
                          studentMainController.zoneName.value =
                              studentMainController
                                  .getRegion.value.data[index].name
                                  .toString();
                          studentMainController.update();
                          _showDialogForLevel(context: context);
                        },
                      );
                    },
                  ),
          ),
        ));
  }

  _showDialogForLevel({required BuildContext context}) async {
    studentMainController.getLevelApiCall();
    return AppWidget.commanDialog(
        context: context,
        titleText: AppStrings.chooseEducationLevel,
        widget: Obx(() => Container(
              width: double.maxFinite,
              child: studentMainController.getLevel.value.data == []
                  ? Text('No record found')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          studentMainController.getLevel.value.data.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(studentMainController
                              .getLevel.value.data[index].name
                              .toString()),
                          value: studentMainController
                              .getLevel.value.data[index].name
                              .toString(),
                          selected: false,
                          groupValue:
                              studentMainController.radioGroupValue.value,
                          onChanged: (v) {
                            studentMainController.radioGroupValue.value = v!;
                            studentMainController.levelId.value =
                                studentMainController
                                    .getLevel.value.data[index].id
                                    .toString();
                            studentMainController.update();
                            if (studentMainController.indexForDialog.value ==
                                0) {
                              studentMainController.endPointForStream.value =
                                  '${Apis.getAllStream}${studentMainController.getLevel.value.data[index].id}';
                              studentMainController.update();
                            } else if (studentMainController
                                    .indexForDialog.value ==
                                1) {
                              studentMainController.endPointForStream.value =
                                  '${Apis.getAllUniversityStream}${studentMainController.getLevel.value.data[index].id}';
                              studentMainController.update();
                            } else {
                              studentMainController.endPointForStream.value =
                                  '${Apis.getAllCourseStream}${studentMainController.getLevel.value.data[index].id}';
                              studentMainController.update();
                            }

                            Get.back();
                            _showDialogForStream(context: context);
                          },
                        );
                      },
                    ),
            )));
  }

  _showDialogForStream({required BuildContext context}) {
    studentMainController.getStreamApiCall();
    return AppWidget.commanDialog(
        context: context,
        titleText: AppStrings.chooseStream,
        widget: Obx(() => Container(
              width: double.maxFinite,
              child: studentMainController.getStream.value.data == []
                  ? Text('No record found')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          studentMainController.getStream.value.data.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Obx(
                          () {
                            return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(studentMainController
                                  .getStream.value.data[index].name
                                  .toString()),
                              value: studentMainController
                                  .getStream.value.data[index].name
                                  .toString(),
                              selected: false,
                              groupValue:
                                  studentMainController.radioGroupValue.value,
                              onChanged: (v) {
                                studentMainController.radioGroupValue.value =
                                    v!;
                                studentMainController.streamId.value =
                                    studentMainController
                                        .getStream.value.data[index].id
                                        .toString();
                                studentMainController.update();
                                Get.back();
                                if (studentMainController
                                        .indexForDialog.value ==
                                    0) {
                                  studentMainController.getAllScholarship();
                                  Get.toNamed(RouteHelper.allScholarship);
                                } else if (studentMainController
                                        .indexForDialog.value ==
                                    1) {
                                  studentMainController.getAllUniversity();
                                  Get.toNamed(RouteHelper.allUniversity);
                                } else {
                                  studentMainController.getAllCourse();
                                  Get.toNamed(RouteHelper.allCourses);
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
            )));
  }
}
