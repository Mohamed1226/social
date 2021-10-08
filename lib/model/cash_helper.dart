import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {required String key, required String value}) async {
    return await prefs.setString(key, value);
  }

  static String? getData(String key) {
    return prefs.getString(key);
  }
}
