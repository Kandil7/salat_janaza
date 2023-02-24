import 'package:shared_preferences/shared_preferences.dart';
class CachHelper{
  static CachHelper _instance = CachHelper._init();
  static SharedPreferences? _sharedPreferences;

  CachHelper._init();

  factory CachHelper() => _instance;

  Future<SharedPreferences> init() async {
    if (_sharedPreferences != null) return _sharedPreferences!;
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  static Future<bool> putData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _sharedPreferences!.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      return await _sharedPreferences!.setBool(key, value);
    } else {
      return await _sharedPreferences!.setDouble(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return _sharedPreferences?.get(key);
  }
}