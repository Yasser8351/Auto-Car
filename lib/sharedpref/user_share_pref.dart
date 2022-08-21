import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUser {
  late SharedPreferences _prefs;
  // Future<bool> login(String uid) async {
  //   _prefs = await SharedPreferences.getInstance();
  //   await _prefs.setString('id', uid);
  //   return await _prefs.setBool('login', true);
  // }

  Future<bool> isLogin() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('login') ?? false;
  }

  Future<String> getID() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getString('id') ?? '');
  }

  Future<void> saveId(String uid) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('id', uid);
  }
}
