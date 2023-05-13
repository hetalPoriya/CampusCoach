import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/utils/utils.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  StudentAuthController studentAuthController =
      Get.put(StudentAuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      height: double.infinity,
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
                  height: 16.h,
                  width: 50.w,
                  child: Image.asset(AppAssets.campusCoachLogo),
                ),
                mediumSizedBox,
                Text(AppStrings.forgotPassScreen,
                    style: AppStyles.largeTextStyle),
                mediumSizedBox,
                Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
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
                            Text(AppStrings.forgotPassText,
                                style: AppStyles.extraSmallTextStyle.copyWith(
                                  color: AppColors.brown,
                                )),
                            smallSizedBox,
                            AppWidget.textFormField(
                                hintText: AppStrings.enterEmail,
                                prefixIcon: Icons.email,
                                controller:
                                    studentAuthController.emailCon.value,
                                validator: FormValidation.emailValidation(
                                    value: studentAuthController
                                        .emailCon.value.text),
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done),
                            extraLargeSizedBox,
                            Padding(
                              padding: paddingSymmetric(horizontal: 10.w),
                              child: AppWidget.signInButton(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await studentAuthController
                                          .studentForgotPassApiCall();
                                    }
                                  },
                                  text: AppStrings.submit),
                            ),
                            mediumSizedBox,
                          ]),
                        ),
                      )),
                ),
              ],
            ),
            Obx(
              () => studentAuthController.isLoading.value == true
                  ? AppWidget.progressIndicator()
                  : Container(),
            )
          ],
        ),
      ),
    ));
  }
}
