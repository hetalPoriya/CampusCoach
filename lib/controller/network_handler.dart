import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;

import '../views/widgets.dart';

class NetworkHandler {
  static Dio dio = Dio();

  //apis
  static String buildUrl(String endpoint) {
    String host = 'http://techharrier.com/mycampuscoach/admin/app_apinof/';
    final apiPath = host + endpoint;
    return apiPath;
  }

  static Options options = Options(headers: {
    'Accept': 'application/json',
  });

  static Future<String> getApi({required String endpoint}) async {
    try {
      var response = await dio.get(buildUrl(endpoint));
      log('StatusCode ${response.statusCode}');
      log('Body ${response.data}');
      return response.data;
    } on DioError catch (e) {
      var response = await dio.get(buildUrl(endpoint));
      return response.data;
    }
  }

  static Future postAPi({dynamic body, required String endpoint}) async {
    try {
      log(buildUrl(endpoint));

      var response =
          await dio.post(buildUrl(endpoint), data: d.FormData.fromMap(body));
      log('Body ${response.data}');
      return response.data;
    } on DioError catch (e) {
      AppWidget.flutterToast(msg: e.toString());
      var response = await dio.post(
        buildUrl(endpoint),
        data: body,
        options: options,
      );
      return response.data;
    }
  }

  Future<bool> checkConnectivity() async {
    try {
      bool isConnected;
      var _connectivity = await (Connectivity().checkConnectivity());
      if (_connectivity == ConnectivityResult.mobile) {
        isConnected = true;
      } else if (_connectivity == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }

      if (isConnected) {
        try {
          // AppWidgets.flutterToast(msg: '');
        } on SocketException catch (_) {
          isConnected = false;
        }
      }

      return isConnected;
    } catch (e) {
      log('Exception - NetworkHandler.dart - checkConnectivity(): $e');
    }
    return false;
  }
}
