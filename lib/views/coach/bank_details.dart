import 'dart:developer';

import 'package:campus_coach/controller/coach/coach_auth_controller.dart';
import 'package:campus_coach/controller/coach/coach_controller.dart';
import 'package:campus_coach/utils/apis.dart';
import 'package:campus_coach/utils/app_strings.dart';
import 'package:campus_coach/utils/app_styles.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  CoachAuthController coachAuthController = Get.put(CoachAuthController());
  CoachController coachController = Get.put(CoachController());
  // getProfile() async {
  //   await coachAuthController.getCoachProfile();
  //   log('${Apis.studentImageUrl}${coachAuthController.imageCon.value.toString()}');
  // }
  //
  // @override
  // void initState() {
  //   getProfile();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
        appBarString: AppStrings.bankDetails,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: ListView(
                padding: paddingSymmetric(vertical: 2.h, horizontal: 4.w),
                children: [
                  smallSizedBox,
                  AppWidget.textFormField(
                      prefixIcon: Icons.person,
                      hintText: AppStrings.accountHolderName,
                      controller:
                          coachAuthController.accountHolderNameCon.value),
                  smallSizedBox,
                  AppWidget.textFormField(
                    prefixIcon: Icons.confirmation_number,
                    hintText: AppStrings.accountNumber,
                    controller: coachAuthController.accountNumberCon.value,
                    textInputType: TextInputType.number,
                  ),
                  smallSizedBox,
                  AppWidget.textFormField(
                      prefixIcon: Icons.villa,
                      hintText: AppStrings.backName,
                      controller: coachAuthController.bankNameCon.value),
                  smallSizedBox,
                  AppWidget.textFormField(
                      prefixIcon: Icons.confirmation_number,
                      hintText: AppStrings.ifscCode,
                      controller: coachAuthController.ifscCodeCon.value,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done),
                  mediumSizedBox,
                  Padding(
                    padding: paddingSymmetric(horizontal: 10.w),
                    child: AppWidget.signInButton(
                        onTap: () async =>
                            await coachController.updateBankDetailsApiCall(),
                        text: AppStrings.update),
                  )
                ],
              ),
            ),
            Obx(
              () => coachController.isLoading.value == true
                  ? AppWidget.progressIndicator()
                  : Container(),
            )
          ],
        ));
  }
}
