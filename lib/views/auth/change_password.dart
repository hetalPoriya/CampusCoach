import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/utils/utils.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../background_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  StudentAuthController studentAuthController =
      Get.put(StudentAuthController());

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      appBarString: AppStrings.updatePassword,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: paddingSymmetric(horizontal: 4.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      largeSizedBox,
                      Obx(
                        () => AppWidget.textFormField(
                            controller: studentAuthController.oldPassCon.value,
                            hintText: AppStrings.enterOldPass,
                            prefixIcon: Icons.lock,
                            onPressedOnSuffixIcon: () {
                              studentAuthController.isVisible.value =
                                  !studentAuthController.isVisible.value;
                              studentAuthController.update();
                            },
                            isVisible: studentAuthController.isVisible.value,
                            suffixIcon:
                                studentAuthController.isVisible.value == true
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                            validator: FormValidation.passwordValidation(
                                value: studentAuthController
                                    .oldPassCon.value.text),
                            textInputAction: TextInputAction.done),
                      ),
                      smallerSizedBox,
                      Obx(
                        () => AppWidget.textFormField(
                            controller: studentAuthController.newPassCon.value,
                            hintText: AppStrings.enterNewPass,
                            prefixIcon: Icons.lock,
                            onPressedOnSuffixIcon: () {
                              studentAuthController.isNewVisible.value =
                                  !studentAuthController.isNewVisible.value;
                              studentAuthController.update();
                            },
                            isVisible: studentAuthController.isNewVisible.value,
                            suffixIcon:
                                studentAuthController.isNewVisible.value == true
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                            validator: FormValidation.passwordValidation(
                                value: studentAuthController
                                    .newPassCon.value.text),
                            textInputAction: TextInputAction.done),
                      ),
                      smallerSizedBox,
                      Obx(
                        () => AppWidget.textFormField(
                            controller:
                                studentAuthController.confirmNewPassCon.value,
                            hintText: AppStrings.enterConfirmNewPass,
                            prefixIcon: Icons.lock,
                            onPressedOnSuffixIcon: () {
                              studentAuthController.isConfirmNewVisible.value =
                                  !studentAuthController
                                      .isConfirmNewVisible.value;
                              studentAuthController.update();
                            },
                            isVisible:
                                studentAuthController.isConfirmNewVisible.value,
                            suffixIcon: studentAuthController
                                        .isConfirmNewVisible.value ==
                                    true
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            validator: FormValidation.passwordValidation(
                                value: studentAuthController
                                    .confirmNewPassCon.value.text),
                            textInputAction: TextInputAction.done),
                      ),
                      extraLargeSizedBox,
                      Padding(
                        padding: paddingSymmetric(horizontal: 10.w),
                        child: AppWidget.signInButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                if (studentAuthController
                                        .newPassCon.value.text !=
                                    studentAuthController
                                        .confirmNewPassCon.value.text) {
                                  AppWidget.flutterToast(
                                      msg:
                                          'New password and confirm password are not same.');
                                } else {
                                  await studentAuthController
                                      .studentUpdatePasswordApiCall(
                                          oldPassword: studentAuthController
                                              .oldPassCon.value.text,
                                          newPassword: studentAuthController
                                              .newPassCon.value.text);
                                }
                              }
                            },
                            text: AppStrings.update),
                      ),
                      mediumSizedBox,
                    ]),
              ),
            ),
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
