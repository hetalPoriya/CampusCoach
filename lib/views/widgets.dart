import 'dart:developer';
import 'dart:io';
import 'package:campus_coach/controller/controller.dart';
import 'package:campus_coach/model/student/get_scholarship_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../model/model.dart';
import '../utils/utils.dart';

class AppWidget {
  static CoachAuthController coachAuthController =
      Get.put(CoachAuthController());
  static StudentAuthController studentAuthController =
      Get.put(StudentAuthController());

  static signInButton(
          {required VoidCallback onTap,
          required String text,
          Color? color,
          double? fontSize,
          Size? size}) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: size ?? Size(double.infinity, 12.w),
              maximumSize: size ?? Size(double.infinity, 12.w),
              elevation: 2.w,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.w)),
              backgroundColor: color ?? AppColors.darkBlue),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: fontSize ?? 12.sp),
          ));

  static textFormField(
          {String? Function(String?)? validator,
          void Function()? onPressedOnSuffixIcon,
          IconData? prefixIcon,
          IconData? suffixIcon,
          TextInputType? textInputType,
          TextInputAction? textInputAction,
          required String hintText,
          bool isVisible = false,
          Color? borderColor,
          TextEditingController? controller,
          EdgeInsetsGeometry? contentPadding}) =>
      TextFormField(
          validator: validator,
          keyboardType: textInputType ?? TextInputType.text,
          textInputAction: textInputAction ?? TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText: isVisible,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: Colors.grey.shade700),
            suffixIcon: IconButton(
                icon: Icon(suffixIcon),
                onPressed: onPressedOnSuffixIcon,
                color: Colors.grey.shade700),
            label: Text(hintText,
                style: TextStyle(
                  color: Colors.grey.shade700,
                )),
            contentPadding: contentPadding,
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red, style: BorderStyle.solid, width: 2)),
            filled: true,
            fillColor: AppColors.textFieldColor,
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: borderColor ?? Colors.grey.shade600)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black, style: BorderStyle.solid, width: 2)),
          ));

  static richText({required String text1, void Function()? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
              text: text1,
              style: AppStyles.extraSmallTextStyle,
              children: [
                TextSpan(
                    text: AppStrings.clickHere,
                    style: AppStyles.extraSmallTextStyle
                        .copyWith(color: AppColors.brown))
              ]),
        ),
      );

  static appBar({required String text, double? elevation}) => AppBar(
      backgroundColor: AppColors.darkBlue,
      elevation: elevation,
      title: Text(text,
          style: AppStyles.mediumTextStyle.copyWith(color: Colors.white)),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios_rounded),
      ));

  static Widget customContainer(
          {required BuildContext context,
          required Color color,
          required String text,
          required VoidCallback onTap}) =>
      Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2, blurRadius: 3, color: Colors.black12)
                ],
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(4.w)),
            child: Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipPath(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(4.w)),
                          padding: EdgeInsets.only(bottom: 3.h, top: 2.h),
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                              ),
                              maxRadius: 6.w,
                              minRadius: 6.w),
                        ),
                        clipper: CustomClipPath(),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: AppStyles.smallTextStyle,
                    )),
                  ]),
            ),
          ),
        ),
      );

  static final studentMainController = Get.put(StudentMainController());

  static commanDialog({
    required BuildContext context,
    required String titleText,
    required Widget widget,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            // height: 50.h,
            child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.w),
                ),
                titlePadding: EdgeInsets.zero,
                title: Container(
                    padding: paddingSymmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4.w),
                          topLeft: Radius.circular(4.w)),
                      color: AppColors.darkBlue,
                    ),
                    child: Row(
                      children: [
                        Text(
                          titleText,
                          style: AppStyles.smallTextStyle
                              .copyWith(color: Colors.white),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.highlight_remove),
                          color: Colors.white,
                        )
                      ],
                    )),
                contentPadding: EdgeInsets.zero,
                content: Obx(() => studentMainController.isLoading.value == true
                    ? SizedBox(
                        height: 7.h,
                        child: AppWidget.normalProgressIndicator(),
                      )
                    : widget)),
          );
        },
      );

  static darkBlueContainer(
          {required BuildContext context,
          required String titleText,
          String? text,
          Widget? widget}) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
            color: Colors.white,
            boxShadow: [
              BoxShadow(spreadRadius: 4, color: Colors.black12, blurRadius: 4)
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: paddingSymmetric(vertical: 1.h, horizontal: 2.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3.w),
                    topRight: Radius.circular(3.w)),
                color: AppColors.darkBlue),
            child: Text(titleText,
                style: AppStyles.extraSmallTextStyle
                    .copyWith(color: Colors.white)),
          ),
          Padding(
              padding: paddingSymmetric(vertical: 2.h, horizontal: 4.w),
              child: widget ?? htmlWidget(text: text))
        ]),
      );

  static progressIndicator() => Center(
        child: Container(
            height: 8.h,
            width: 16.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              color: Colors.black54,
            ),
            padding: paddingSymmetric(horizontal: 3.w, vertical: 2.h),
            child: CircularProgressIndicator(
              backgroundColor: Colors.black12,
              color: Colors.white,
            )),
      );

  static normalProgressIndicator() => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.black12,
          color: Colors.white,
        ),
      );

  static flutterToast({required String msg}) => Fluttertoast.showToast(
      msg: msg, backgroundColor: AppColors.darkBlue, textColor: Colors.white);

  static showDialogForImage({required BuildContext context}) {
    return Get.defaultDialog(
        title: 'From where do you want to take the photo?',
        titleStyle: AppStyles.mediumTextStyle,
        contentPadding: EdgeInsets.zero,
        content: Padding(
          padding: paddingSymmetric(horizontal: 5.w, vertical: 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    _pickFromGalley();
                  },
                  child: Text(
                    'Gallery',
                    style:
                        AppStyles.smallTextStyle.copyWith(color: Colors.black),
                  ),
                ),
                smallerSizedBox,
                GestureDetector(
                  onTap: () {
                    Get.back();
                    _pickFromCamera();
                  },
                  child: Text(
                    'Camera',
                    style:
                        AppStyles.smallTextStyle.copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  static _pickFromGalley() async {
    File? pickedImage;
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    pickedImage = File(image.path);

    log('Image ${image.path}');

    if (SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0) {
      await studentAuthController.studentUpdateProfileApiCall(
          pickedImage: pickedImage);
    } else {
      await coachAuthController.coachUpdateProfileApiCall(
          pickedImage: pickedImage);
    }
    coachAuthController.update();
  }

  static _pickFromCamera() async {
    File? pickedImage;
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    pickedImage = File(image.path);

    log('Image ${image.path}');
    log('Image111 ${pickedImage.path}');
    if (SharedPrefClass.getInt(SharedPrefStrings.isStudent) == 0) {
      await studentAuthController.studentUpdateProfileApiCall(
          pickedImage: pickedImage);
    } else {
      await coachAuthController.coachUpdateProfileApiCall(
          pickedImage: pickedImage);
    }

    coachAuthController.update();
  }

  static circleAvtarWidget(
      {String? response, double? minRadius, double? minRadius1}) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      // minRadius: minRadius,
      radius: minRadius ?? 10.w,
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        radius: minRadius1 ?? 9.8.w,
        //minRadius: minRadius1,
        onForegroundImageError: (e, s) {
          debugPrint('image issue, $e,$s');
        },
        foregroundImage: response!.isNotEmpty
            ? NetworkImage(response.toString())
            : AssetImage(AppAssets.campusCoachLogo) as ImageProvider,
      ),
    );
  }

  static htmlWidget({String? text, double? fontSize}) {
    return Html(data: text, style: {
      "body": Style(
        fontSize: FontSize(fontSize ?? 11.sp),
        fontWeight: FontWeight.w400,
      ),
    });
  }

  static showDialogForAppointments(
      {required BuildContext context,
      required String titleText,
      required String subText,
      required VoidCallback onPressed}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titleText, style: AppStyles.mediumTextStyle),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              subText,
              style: AppStyles.smallTextStyle,
            ),
          ]),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(AppStrings.no,
                    style: AppStyles.smallTextStyle
                        .copyWith(color: Colors.grey.shade700))),
            TextButton(
                onPressed: onPressed,
                child: Text(AppStrings.yes,
                    style: AppStyles.smallTextStyle
                        .copyWith(color: Colors.grey.shade700))),
          ],
        );
      },
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
