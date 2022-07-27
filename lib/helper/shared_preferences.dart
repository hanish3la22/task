import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper{

  static Future<bool> setUserId(String? id) async{
    final pref  = await SharedPreferences.getInstance();
    return await pref.setString("id",id!);
  }

  static Future<String?> getUserId() async{
    final pref  = await SharedPreferences.getInstance();
    return await pref.getString('id');
  }
}