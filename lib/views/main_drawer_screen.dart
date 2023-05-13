import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/model/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../utils/utils.dart';

class MainDrawerScreen {
  static final _advancedDrawerController = AdvancedDrawerController();
  static StudentAuthController studentAuthController =
      Get.put(StudentAuthController());
  static advanceDrawer(
          {required BuildContext context,
          required List<DrawerMenu> drawerMenu,
          required Widget child,
          bool showImage = true}) =>
      WillPopScope(
          child: AdvancedDrawer(
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            openRatio: 0.50,
            openScale: 0.65,
            // openScale: 1.0,
            disabledGestures: false,
            childDecoration: BoxDecoration(
                // NOTICE: Uncomment if you want to add shadow behind the page.
                // Keep in mind that it may cause animation jerks.
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 0.0,
                //   ),
                // ],
                //borderRadius: BorderRadius.all(Radius.circular(4.w)),
                ),
            child: Scaffold(
              backgroundColor:
                  showImage == true ? Color(0xffDDEFFB) : Colors.white,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: AppColors.darkBlue,
                title: Text(AppStrings.myCampusCoach),
                leading: IconButton(
                  onPressed: () => _advancedDrawerController.showDrawer(),
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: showImage == true
                      ? BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppAssets.backgroundImage),
                              fit: BoxFit.fill))
                      : BoxDecoration(),
                  child: child),
            ),
            drawer: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: ListTileTheme(
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      mediumSizedBox,
                      Obx(
                        () => CircleAvatar(
                          minRadius: 15.w,
                          maxRadius: 15.w,
                          backgroundColor: Colors.black,
                          backgroundImage: studentAuthController
                                  .imageCon.isEmpty
                              ? AssetImage(AppAssets.campusCoachLogo)
                                  as ImageProvider
                              : NetworkImage(
                                  '${Apis.studentImageUrl}${studentAuthController.imageCon.value.toString()}'),
                        ),
                      ),
                      smallSizedBox,
                      Center(
                          child: Text(
                              'Welcome, ${SharedPrefClass.getString(SharedPrefStrings.name)}',
                              style: AppStyles.mediumTextStyle)),
                      Center(
                          child: Text(
                              '${SharedPrefClass.getString(SharedPrefStrings.email)}',
                              style: AppStyles.smallTextStyle)),
                      mediumSizedBox,
                      Column(
                        children: List.generate(
                          drawerMenu.length,
                          (index) => ListTile(
                            onTap: () {
                              _advancedDrawerController.hideDrawer();
                              if (drawerMenu[index].text == 'Logout') {
                                showDialogForLogOut(context);
                              } else {
                                Get.toNamed(drawerMenu[index].route);
                              }
                            },
                            leading: Icon(drawerMenu[index].icon),
                            title: Text(drawerMenu[index].text),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          onWillPop: () => showDialogForBackButton(context));

  static Future<dynamic> showDialogForLogOut(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout', style: AppStyles.mediumTextStyle),
          content:
              Text(AppStrings.logOutOrNot, style: AppStyles.smallTextStyle),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'No',
                  style: AppStyles.smallTextStyle.copyWith(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Get.back();

                  SharedPrefClass.setBool(SharedPrefStrings.isLogin, false);
                  SharedPrefClass.remove(SharedPrefStrings.email);
                  SharedPrefClass.remove(SharedPrefStrings.password);
                  SharedPrefClass.clear();
                  Get.toNamed(RouteHelper.studentOrCoachSignIn);
                },
                child: Text(
                  'Yes',
                  style: AppStyles.smallTextStyle.copyWith(color: Colors.black),
                )),
          ],
        );
      },
    );
  }

  static Future<bool> showDialogForBackButton(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Exit App', style: AppStyles.mediumTextStyle),
          content: Text('Do you want to exit an App?',
              style: AppStyles.smallTextStyle),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: AppStyles.smallTextStyle.copyWith(color: Colors.black),
                )),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Yes',
                  style: AppStyles.smallTextStyle.copyWith(color: Colors.black),
                )),
          ],
        );
      },
    );
  }
}
