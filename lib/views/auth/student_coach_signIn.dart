import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/views/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class StudentOrCoachSignIn extends StatelessWidget {
  const StudentOrCoachSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.backgroundImage),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: paddingSymmetric(horizontal: 6.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                largeSizedBox,
                Container(
                  height: 20.h,
                  width: 50.w,
                  child: Image.asset(
                    AppAssets.campusCoachLogo,
                  ),
                ),
                extraLargeSizedBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.welcomeText,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 1.w,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.studentOrCoachSpecify,
                    style: TextStyle(fontSize: 10.sp, color: AppColors.grey),
                  ),
                ),
                extraLargeSizedBox,
                AppWidget.signInButton(
                    onTap: () async {
                      await SharedPrefClass.setInt(
                          SharedPrefStrings.isStudent, 0);

                      Get.toNamed(RouteHelper.signIn);
                    },
                    text: AppStrings.signInAsStudent),
                smallSizedBox,
                AppWidget.signInButton(
                    onTap: () async {
                      await SharedPrefClass.setInt(
                          SharedPrefStrings.isStudent, 1);
                      Get.toNamed(RouteHelper.signIn);
                    },
                    text: AppStrings.signInAsCoach,
                    color: AppColors.lightBlue),
                smallSizedBox,
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
