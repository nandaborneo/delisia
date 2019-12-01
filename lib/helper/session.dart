import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<bool> setAccessToken(String accesstoken) async {
    final SharedPreferences preferences = await _prefs;
    return preferences.setString("AccessToken", accesstoken);
  }

  static Future<String> getAccessToken() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("AccessToken");
  }

  static Future<bool> setStaffId(String staffid) async {
    final SharedPreferences preferences = await _prefs;
    return preferences.setString("staff_id", staffid);
  }

  static Future<String> getStaffId() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("staff_id");
  }

  static Future<bool> setUserId(String userid) async {
    final SharedPreferences preferences = await _prefs;
    return preferences.setString("user_id", userid);
  }

  static Future<String> getUserId() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("user_id");
  }

   static Future<bool> setUserNama(String usernama) async {
    final SharedPreferences preferences = await _prefs;
    return preferences.setString("user_nama", usernama);
  }

  static Future<String> getUserNama() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("user_nama");
  }
}
