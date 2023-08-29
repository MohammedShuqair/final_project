import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  SharedHelper._();
  static final SharedHelper _instance = SharedHelper._();
  factory SharedHelper() {
    return _instance;
  }

  late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setString(key, value);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<void> setToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  String getToken() {
    return sharedPreferences.getString('token') ?? '';
  }
}
