import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static const String nameKey = 'NAMEKEY';
  static const String emailKey = 'EMAILKEY';
  static const String imageKey = 'IMAGEKEY';
  static const String isLoginKey = 'ISLOGINKEY';

  static Future<bool?> saveName(String name) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(nameKey, name);
  }

  static Future<bool?> saveEmail(String email) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(emailKey, email);
  }

  static Future<bool?> saveImage(String image) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(imageKey, image);
  }

  static Future<bool?> saveLoginState(bool login) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(isLoginKey, login);
  }

  static Future<String?> getName() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(nameKey);
  }

  static Future<String?> getEmail() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(emailKey);
  }

  static Future<String?> getImage() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(imageKey);
  }

  static Future<bool?> getLoginState() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isLoginKey);
  }



}
