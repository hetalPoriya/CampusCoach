import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefClass {
  static SharedPrefClass? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<SharedPrefClass?> getInstance() async {
    _preferences = await SharedPreferences.getInstance();
    if (_storageUtil == null) {
      var secureStorage = SharedPrefClass._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  SharedPrefClass._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// put integer
  static Future<bool>? setInt(String key, int value) {
    if (_preferences == null) return null;
    return _preferences!.setInt(key, value);
  }

  /// get integer
  static int getInt(String key, {int defValue = 0}) {
    if (_preferences == null) return defValue;
    return _preferences!.getInt(key) ?? defValue;
  }

  /// put String
  static Future<bool>? setString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences!.setString(key, value);
  }

  /// Get String
  static String getString(String key, {String defValue = ""}) {
    if (_preferences == null) return defValue;
    return _preferences!.getString(key) ?? defValue;
  }

  static Future<bool> remove(String key) async {
    return _preferences!.remove(key);
  }

  /// put StringList
  static Future<bool>? setStringList(String key, List<String> value) {
    if (_preferences == null) return null;
    return _preferences!.setStringList(key, value);
  }

  /// Get StringList
  static List<String>? getStringList(String key) {
    // if (_preferences == null) return defValue;
    return _preferences!.getStringList(key);
  }

  static bool getBool(String key, bool defValue) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  static setBool(String key, bool value) async {
    _preferences?.setBool(key, value);
  }

  static clear() async {
    _preferences!.clear();
  }
}
