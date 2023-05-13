import 'package:get/get_utils/src/get_utils/get_utils.dart';

class FormValidation {
  static String? Function(String?)? emailValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email address';
        } else if (!GetUtils.isEmail(value)) {
          return 'Please enter valid email';
        }
        return null;
      };

  static String? Function(String?)? emptyValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      };

  static String? Function(String?)? passwordValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      };

  static String? Function(String?)? mobileNumberValidation({String? value}) =>
      (value) {
        String pattern = r'(^[0-9]{10}$)';
        RegExp regExp = new RegExp(pattern);
        if (value == null || value.isEmpty) {
          return 'Please enter your mobile number';
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter valid mobile number';
        }
        return null;
      };
}
