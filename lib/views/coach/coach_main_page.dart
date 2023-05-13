import 'package:campus_coach/controller/coach/coach_controller.dart';
import 'package:campus_coach/helper/route_helper.dart';
import 'package:campus_coach/model/drawer_menu.dart';
import 'package:campus_coach/views/main_drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/utils.dart';
import '../views.dart';

class CoachMainPage extends StatefulWidget {
  CoachMainPage({Key? key}) : super(key: key);

  @override
  State<CoachMainPage> createState() => _CoachMainPageState();
}

class _CoachMainPageState extends State<CoachMainPage> {
  CoachController coachController = Get.put(CoachController());

  getUpcomingAppointment() async {
    await coachController.coachUpcomingBookingApiCall();
  }

  @override
  void initState() {
    getUpcomingAppointment();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<DrawerMenu> drawerMenu = [
    DrawerMenu(
        text: AppStrings.profile,
        icon: Icons.person,
        route: RouteHelper.profile),
    DrawerMenu(
        text: AppStrings.bankDetails,
        icon: Icons.comment_bank_outlined,
        route: RouteHelper.bankDetails),
    DrawerMenu(
        text: AppStrings.workingHours,
        icon: Icons.access_time_rounded,
        route: RouteHelper.workingHours),
    DrawerMenu(text: AppStrings.logOut, icon: Icons.logout, route: ''),
  ];

  List<Widget> list = [
    UpcomingAppointment(),
    AcceptedAppointment(),
    CancelledAppointment(),
  ];

  @override
  Widget build(BuildContext context) {
    CoachController coachController = Get.put(CoachController());

    // return SafeArea(
    //     child: Scaffold(
    //   body: Container(),
    // ));
    return Container(
        color: Colors.white,
        child: MainDrawerScreen.advanceDrawer(
          showImage: false,
          context: context,
          drawerMenu: drawerMenu,
          child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  smallSizedBox,
                  Container(
                    padding: paddingAll(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.w),
                      color: Colors.blueGrey.shade50,
                      border: Border.all(color: Colors.black),
                    ),
                    child: TabBar(
                        onTap: (i) async {
                          coachController.coachTabIndex.value = i;
                          if (i == 0) {
                            await coachController.coachUpcomingBookingApiCall();
                          } else if (i == 1) {
                            await coachController.coachAcceptedBookingApiCall();
                          } else {
                            await coachController
                                .coachCancelledBookingApiCall();
                          }
                          coachController.update();
                        },
                        unselectedLabelColor: Colors.grey,
                        unselectedLabelStyle: AppStyles.extraSmallTextStyle,
                        labelStyle: AppStyles.extraSmallTextStyle,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.w),
                            color: Color(0xff2e5cb8)),
                        tabs: [
                          Tab(
                            text: AppStrings.upcoming,
                          ),
                          Tab(
                            text: AppStrings.accepted,
                          ),
                          Tab(
                            text: AppStrings.cancelled,
                          ),
                        ]),
                  ),
                  Expanded(
                      child: Obx(() => coachController.isLoading.value == true
                          ? AppWidget.progressIndicator()
                          : list
                              .elementAt(coachController.coachTabIndex.value)))
                ],
              )),
        ));
  }
}
