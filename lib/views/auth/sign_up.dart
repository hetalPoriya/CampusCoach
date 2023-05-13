import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/utils/utils.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  StudentAuthController studentAuthController =
      Get.put(StudentAuthController());
  CoachAuthController coachAuthController = Get.put(CoachAuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.backgroundImage), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: [
                smallSizedBox,
                Container(
                  height: 13.h,
                  width: 50.w,
                  child: Image.asset(AppAssets.campusCoachLogo),
                ),
                mediumSizedBox,
                Text(
                    SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0
                        ? AppStrings.studentRegistration
                        : AppStrings.coachRegistration,
                    style: AppStyles.largeTextStyle),
                mediumSizedBox,
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: paddingSymmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 1,
                                color: Colors.black12)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.w),
                              topRight: Radius.circular(6.w))),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            smallSizedBox,
                            Text(
                                SharedPrefClass.getInt(
                                            SharedPrefStrings.isStudent) ==
                                        0
                                    ? AppStrings.createStudentAccount
                                    : AppStrings.createCoachAccount,
                                textAlign: TextAlign.center,
                                style: AppStyles.extraSmallTextStyle.copyWith(
                                  color: AppColors.brown,
                                )),
                            smallSizedBox,
                            AppWidget.textFormField(
                                hintText: AppStrings.enterName,
                                prefixIcon: Icons.person,
                                controller: studentAuthController.nameCon.value,
                                validator: FormValidation.emptyValidation(
                                    value: studentAuthController
                                        .nameCon.value.text)),
                            smallSizedBox,
                            AppWidget.textFormField(
                                hintText: AppStrings.enterPhoneNumber,
                                prefixIcon: Icons.phone,
                                textInputType: TextInputType.number,
                                controller:
                                    studentAuthController.phoneNumberCon.value,
                                validator:
                                    FormValidation.mobileNumberValidation(
                                        value: studentAuthController
                                            .phoneNumberCon.value.text)),
                            smallSizedBox,
                            AppWidget.textFormField(
                                hintText: AppStrings.enterEmail,
                                prefixIcon: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                controller:
                                    studentAuthController.emailCon.value,
                                validator: FormValidation.emailValidation(
                                    value: studentAuthController
                                        .emailCon.value.text)),
                            smallSizedBox,
                            Obx(
                              () => AppWidget.textFormField(
                                  controller:
                                      studentAuthController.passCon.value,
                                  hintText: AppStrings.enterPass,
                                  prefixIcon: Icons.lock,
                                  onPressedOnSuffixIcon: () {
                                    studentAuthController.isVisible.value =
                                        !studentAuthController.isVisible.value;
                                    studentAuthController.update();
                                  },
                                  isVisible:
                                      studentAuthController.isVisible.value,
                                  suffixIcon:
                                      studentAuthController.isVisible.value ==
                                              true
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                  validator: FormValidation.passwordValidation(
                                      value: studentAuthController
                                          .passCon.value.text),
                                  textInputAction: TextInputAction.done),
                            ),
                            smallerSizedBox,
                            Align(
                                alignment: Alignment.centerRight,
                                child: AppWidget.richText(
                                    onTap: () => Get.back(),
                                    text1: AppStrings.alreadyHaveAccount)),
                            mediumSizedBox,
                            Padding(
                              padding: paddingSymmetric(horizontal: 10.w),
                              child: AppWidget.signInButton(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      NetworkHandler nr = NetworkHandler();
                                      bool isConnected =
                                          await nr.checkConnectivity();
                                      if (isConnected) {
                                        if (SharedPrefClass.getInt(
                                                SharedPrefStrings.isStudent) ==
                                            0) {
                                          await studentAuthController
                                              .studentSignUpApiCall();
                                        } else {
                                          await coachAuthController
                                              .coachSignUpApiCall();
                                        }
                                      } else {
                                        AppWidget.flutterToast(
                                            msg:
                                                'Please check your connectivity');
                                      }
                                    } else {
                                      AppWidget.flutterToast(
                                          msg: 'Please add correct value');
                                    }
                                  },
                                  text: AppStrings.register),
                            ),
                            mediumSizedBox
                          ]),
                        ),
                      )),
                ),
              ],
            ),
            Obx(() => (studentAuthController.isLoading.value == true)
                ? AppWidget.progressIndicator()
                : Container())
          ],
        ),
      ),
    ));
  }
}
