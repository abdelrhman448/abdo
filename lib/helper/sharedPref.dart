import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<bool> ifExisting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      return false;
    } else {
      return true;
    }
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, object) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(object));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
