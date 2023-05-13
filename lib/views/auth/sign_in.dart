import 'dart:developer';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/utils/utils.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controller/controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                image: AssetImage(AppAssets.backgroundImage),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(
                children: [
                  smallSizedBox,
                  Container(
                    height: 16.h,
                    width: 50.w,
                    child: Image.asset(AppAssets.campusCoachLogo),
                  ),
                  mediumSizedBox,
                  Text(
                      SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0
                          ? AppStrings.studentLogin
                          : AppStrings.coachLogin,
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
                              Text(AppStrings.enterCredentials,
                                  style: AppStyles.extraSmallTextStyle.copyWith(
                                    color: AppColors.brown,
                                  )),
                              smallSizedBox,
                              AppWidget.textFormField(
                                  controller:
                                      studentAuthController.emailCon.value,
                                  hintText: AppStrings.enterEmail,
                                  prefixIcon: Icons.email,
                                  textInputType: TextInputType.emailAddress,
                                  validator: FormValidation.emailValidation(
                                      value: studentAuthController
                                          .emailCon.value.text),
                                  textInputAction: TextInputAction.next),
                              smallSizedBox,
                              Obx(
                                () => AppWidget.textFormField(
                                    controller:
                                        studentAuthController.passCon.value,
                                    hintText: AppStrings.enterPass,
                                    prefixIcon: Icons.lock,
                                    onPressedOnSuffixIcon: () {
                                      studentAuthController.isVisible.value =
                                          !studentAuthController
                                              .isVisible.value;
                                      studentAuthController.update();
                                    },
                                    isVisible:
                                        studentAuthController.isVisible.value,
                                    suffixIcon:
                                        studentAuthController.isVisible.value ==
                                                true
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined,
                                    validator:
                                        FormValidation.passwordValidation(
                                            value: studentAuthController
                                                .passCon.value.text),
                                    textInputAction: TextInputAction.done),
                              ),
                              smallerSizedBox,
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () =>
                                      Get.toNamed(RouteHelper.forgotPassword),
                                  child: Text(
                                    AppStrings.forgotPass,
                                    style: AppStyles.extraSmallTextStyle,
                                  ),
                                ),
                              ),
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
                                                  SharedPrefStrings
                                                      .isStudent) ==
                                              0) {
                                            await studentAuthController
                                                .studentLoginApiCall();
                                          } else {
                                            await coachAuthController
                                                .coachLoginApiCall();
                                          }
                                        } else {
                                          AppWidget.flutterToast(
                                              msg:
                                                  'Please check your connectivity');
                                        }
                                      } else {
                                        log('Please add correct value');
                                        AppWidget.flutterToast(
                                            msg: 'Please add correct value');
                                      }

                                      // if (SharedPrefClass.getInt(
                                      //         SharedPrefStrings.isStudent) ==
                                      //     0) {
                                      //   Get.offNamedUntil(RouteHelper.studentMainPage,
                                      //       (route) => false);
                                      // } else {
                                      //   Get.offNamedUntil(RouteHelper.coachMainPage,
                                      //       (route) => false);
                                      // }
                                    },
                                    text: AppStrings.login),
                              ),
                              extraLargeSizedBox,
                              extraLargeSizedBox,
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: AppWidget.richText(
                                    text1: AppStrings.creatAccount,
                                    onTap: () =>
                                        Get.toNamed(RouteHelper.signUp)),
                              ),
                              mediumSizedBox,
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
      ),
    );
  }
}
