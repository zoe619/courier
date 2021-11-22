// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPref {
  read(String key) async {
    final prefs = new FlutterSecureStorage();
    return json.decode("${await prefs.read(key: key)}");
  }

  save(String key, value) async {
    final prefs = FlutterSecureStorage();
    await prefs.write(key: key, value: json.encode(value));
  }

  remove(String key) async {
    final prefs = FlutterSecureStorage();
    prefs.delete(key: key);
  }
}
