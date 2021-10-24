import 'package:panchat_plus/routes/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future storeUserId(String id) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(PanchatKeys.keyUid, id);
}

Future<String> getUserId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(PanchatKeys.keyUid) ?? "";
}

