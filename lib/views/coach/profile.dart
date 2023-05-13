import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/background_screen.dart';
import 'package:campus_coach/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controller/controller.dart';

import '../../utils/utils.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CoachAuthController coachController = Get.put(CoachAuthController());

  getProfile() async {
    await coachController.getCoachProfile();
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
        appBarString: AppStrings.updateProfile,
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              ListView(
                padding: paddingSymmetric(vertical: 2.h, horizontal: 4.w),
                children: [
                  smallSizedBox,
                  Obx(
                    () => CircleAvatar(
                      minRadius: 15.w,
                      maxRadius: 15.w,
                      backgroundColor: Colors.black,
                      backgroundImage: coachController.imageCon.isEmpty
                          ? AssetImage(AppAssets.campusCoachLogo)
                              as ImageProvider
                          : NetworkImage(
                              '${Apis.coachImageUrl}${coachController.imageCon.value.toString()}'),
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
                  AppWidget.textFormField(
                      hintText: AppStrings.name,
                      prefixIcon: Icons.person,
                      controller: coachController.nameCon.value,
                      validator: FormValidation.emptyValidation(
                          value: coachController.nameCon.value.text)),
                  smallSizedBox,
                  AppWidget.textFormField(
                      hintText: AppStrings.email,
                      prefixIcon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                      controller: coachController.emailCon.value,
                      validator: FormValidation.emailValidation(
                          value: coachController.emailCon.value.text)),
                  smallSizedBox,
                  AppWidget.textFormField(
                      hintText: AppStrings.phoneNumber,
                      prefixIcon: Icons.phone,
                      textInputType: TextInputType.phone,
                      controller: coachController.phoneNumberCon.value,
                      validator: FormValidation.mobileNumberValidation(
                          value: coachController.phoneNumberCon.value.text)),
                  smallSizedBox,
                  AppWidget.textFormField(
                      hintText: AppStrings.videoUrl,
                      controller: coachController.videoUrlCon.value,
                      prefixIcon: Icons.slow_motion_video),
                  smallSizedBox,
                  Container(
                    height: 18.h,
                    padding: paddingSymmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: AppColors.textFieldColor),
                    child: TextField(
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        controller: coachController.aboutMeCon.value,
                        decoration: InputDecoration(
                            hintText: AppStrings.tellYourSelf,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none)),
                  ),
                  smallSizedBox,
                  AppWidget.textFormField(
                      hintText: AppStrings.areaOfExpertise,
                      controller: coachController.areaOfExpertiseCon.value,
                      textInputType: TextInputType.number,
                      prefixIcon: Icons.person),
                  smallSizedBox,
                  AppWidget.textFormField(
                    hintText: AppStrings.experience,
                    prefixIcon: Icons.email,
                    controller: coachController.experienceCon.value,
                    textInputType: TextInputType.number,
                  ),
                  smallSizedBox,
                  AppWidget.textFormField(
                      hintText: AppStrings.priceSession30,
                      textInputType: TextInputType.number,
                      controller: coachController.price30Con.value,
                      prefixIcon: Icons.price_change_outlined),
                  smallSizedBox,
                  AppWidget.textFormField(
                      hintText: AppStrings.priceSession60,
                      textInputType: TextInputType.number,
                      controller: coachController.price60Con.value,
                      prefixIcon: Icons.price_change_outlined),
                  smallSizedBox,
                  Obx(
                    () => Container(
                      child: CheckboxListTile(
                        value: coachController.packageEnable.value,
                        onChanged: (v) {
                          coachController.packageEnable.value = v!;
                          coachController.update();
                        },
                        activeColor: AppColors.darkBlue,
                        checkColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(AppStrings.checkOfferPackage,
                            style: AppStyles.smallTextStyle),
                      ),
                    ),
                  ),
                  smallSizedBox,
                  AppWidget.textFormField(
                      hintText: AppStrings.packagePrice,
                      textInputType: TextInputType.number,
                      controller: coachController.packagePriceCon.value,
                      prefixIcon: Icons.price_change_outlined),
                  smallSizedBox,
                  Container(
                    height: 18.h,
                    padding: paddingSymmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: AppColors.textFieldColor),
                    child: TextField(
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        controller: coachController.aboutPackageCon.value,
                        decoration: InputDecoration(
                            hintText: AppStrings.aboutPackage,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none)),
                  ),
                  smallSizedBox,
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.changePassword),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppStrings.wantToChangePass,
                        style: AppStyles.smallTextStyle.copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.darkBlue),
                      ),
                    ),
                  ),
                  mediumSizedBox,
                  Padding(
                    padding: paddingSymmetric(horizontal: 10.w),
                    child: AppWidget.signInButton(
                        onTap: () async =>
                            await coachController.coachUpdateProfileApiCall(),
                        text: AppStrings.updateProfile),
                  )
                ],
              ),
              Obx(() => coachController.isLoading.value == true
                  ? AppWidget.progressIndicator()
                  : Container()),
            ],
          ),
        ));
  }
}
