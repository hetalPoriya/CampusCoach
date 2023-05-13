// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/instance_manager.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../model/model.dart';
// import '../../utils/utils.dart';
// import '../../views/views.dart';
// import '../controller.dart';
//
// class CoachDrawerController extends GetxController {
//   Dio dio = Dio();
//   RxBool isLoading = false.obs;
//
//   CoachAuthController coachAuthController = Get.put(CoachAuthController());
//   //
//   // //image
//   // File? pickedImage;
//   //
//   // coachUpdateProfileApiCall() async {
//   //   try {
//   //     isLoading(true);
//   //
//   //     CoachProfileBody coachProfileBody = CoachProfileBody(
//   //         qualification: ' ',
//   //         youtubeUrl: coachAuthController.videoUrlCon.value.text,
//   //         userId: '22',
//   //         priceSixty: coachAuthController.price60Con.value.text,
//   //         price: coachAuthController.price30Con.value.text,
//   //         packagePrice: coachAuthController.packagePriceCon.value.text,
//   //         packageEnable:
//   //             coachAuthController.packageEnable.value == true ? 'yes' : 'false',
//   //         experience: coachAuthController.experienceCon.value.text,
//   //         expertise: coachAuthController.areaOfExpertiseCon.value.text,
//   //         packageDesc: coachAuthController.aboutPackageCon.toString(),
//   //         aboutMe: coachAuthController.aboutMeCon.value.text.toString(),
//   //         image: await MultipartFile.fromFile(pickedImage?.path ?? ' ',
//   //             filename: pickedImage?.path.split('/').last));
//   //
//   //     var response = await NetworkHandler.postAPi(
//   //         body: coachProfileBody.toMap(), endpoint: Apis.coachUpdateProfile);
//   //     log('CoachUpdateProfile ${response}');
//   //     var data = jsonDecode(response);
//   //     AppWidget.flutterToast(msg: data[AppStrings.errorMsg]);
//   //
//   //     if (data[AppStrings.error] == '1') {
//   //       log('IMA ${data['image']}');
//   //       coachAuthController.imageCon.value = data['image'];
//   //       coachAuthController.update();
//   //     } else {
//   //       AppWidget.flutterToast(msg: 'Please add you experience And expertise');
//   //     }
//   //   } on DioError catch (e) {
//   //     log('ERROR ${e.toString()}');
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }
// }
