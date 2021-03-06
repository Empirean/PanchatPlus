import 'package:panchat_plus/routes/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future storeSharedPrefUserId(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PanchatKeys.keyUid, id);
    return true;
  }

  Future<String> getSharedPrefUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PanchatKeys.keyUid) ?? "";
  }

  Future storeDeviceToken(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PanchatKeys.keyToken, id);
    return true;
  }

  Future<String> getDeviceToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PanchatKeys.keyToken) ?? "";
  }
}