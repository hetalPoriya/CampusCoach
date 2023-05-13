import 'dart:developer';

import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/controller.dart';
import '../../utils/utils.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  StudentAuthController studentAuthController =
      Get.put(StudentAuthController());
  CoachAuthController coachController = Get.put(CoachAuthController());

  getProfile() async {
    await studentAuthController.getStudentProfile();
    log('${Apis.studentImageUrl}${studentAuthController.imageCon.value.toString()}');
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBarString: AppStrings.editProfile,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  smallSizedBox,
                  Obx(
                    () => CircleAvatar(
                      minRadius: 15.w,
                      maxRadius: 15.w,
                      backgroundColor: Colors.black,
                      backgroundImage: studentAuthController.imageCon.isEmpty
                          ? AssetImage(AppAssets.campusCoachLogo)
                              as ImageProvider
                          : NetworkImage(
                              '${Apis.studentImageUrl}${studentAuthController.imageCon.value.toString()}'),
                    ),
                  ),
                  smallerSizedBox,
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Edit Profile',
                              style: AppStyles.smallTextStyle.copyWith(
                                  decoration: TextDecoration.underline)),
                          Icon(Icons.edit, size: 2.h),
                        ],
                      ),
                      onTap: () =>
                          AppWidget.showDialogForImage(context: context),
                    ),
                  ),
                  mediumSizedBox,
                  Expanded(
                      child: Form(
                    child: Padding(
                      padding: paddingSymmetric(horizontal: 4.w),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          AppWidget.textFormField(
                              hintText: AppStrings.enterName,
                              prefixIcon: Icons.person_pin,
                              controller: studentAuthController.nameCon.value,
                              validator: FormValidation.emptyValidation(
                                  value:
                                      studentAuthController.nameCon.value.text),
                              borderColor: AppColors.textFieldColor),
                          smallSizedBox,
                          AppWidget.textFormField(
                              hintText: AppStrings.enterEmail,
                              prefixIcon: Icons.email,
                              textInputType: TextInputType.emailAddress,
                              controller: studentAuthController.emailCon.value,
                              validator: FormValidation.emailValidation(
                                  value: studentAuthController
                                      .emailCon.value.text),
                              borderColor: AppColors.textFieldColor),
                          smallSizedBox,
                          AppWidget.textFormField(
                              hintText: AppStrings.enterPhoneNumber,
                              prefixIcon: Icons.phone,
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller:
                                  studentAuthController.phoneNumberCon.value,
                              validator: FormValidation.mobileNumberValidation(
                                  value: studentAuthController
                                      .phoneNumberCon.value.text),
                              borderColor: AppColors.textFieldColor),
                          smallerSizedBox,
                          GestureDetector(
                            onTap: () =>
                                Get.toNamed(RouteHelper.changePassword),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                AppStrings.wantToChangePass,
                                style: AppStyles.smallTextStyle.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          largeSizedBox,
                          Padding(
                            padding: paddingSymmetric(horizontal: 13.w),
                            child: AppWidget.signInButton(
                                onTap: () async => await studentAuthController
                                    .studentUpdateProfileApiCall(),
                                text: AppStrings.updateProfile),
                          ),
                          mediumSizedBox
                        ]),
                      ),
                    ),
                  )),
                ]),
            Obx(
              () => studentAuthController.isLoading.value == true
                  ? AppWidget.progressIndicator()
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
