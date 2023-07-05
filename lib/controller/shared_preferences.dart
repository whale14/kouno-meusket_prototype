import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id') ?? '';
  }

  Future<void> setUserId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', value);
  }

  Future<void> setIdx(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idx', value);
  }
}
