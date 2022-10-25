import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper
{
  static SharedPreferences? sharedPreferences ;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setString(String key, String value) async
  {
    return await sharedPreferences?.setString(key, value);
  }

  static String? getString(String key)
  {
    return sharedPreferences?.getString(key);
  }

}