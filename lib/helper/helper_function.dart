import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

class HelperFunction {
//keys
  static String userLoggedInKey = "LOCKEDinKey";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAIL";

  // saing the data sf
  static Future<bool> saveUserLoggedInStatus(bool inUserLoggedin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, inUserLoggedin);
  }

  static Future<bool> saveUserNameSF(String username) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, username);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}
