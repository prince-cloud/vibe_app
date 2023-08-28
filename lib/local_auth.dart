import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
const secureStorage = FlutterSecureStorage();

class LocalCache {
  static getAuthData() async {
    final localAuth = await secureStorage.read(
      key: "auth",
      aOptions: _getAndroidOptions(),
    );
    try {
      return localAuth ?? "";
    } catch (e) {
      return "";
    }
  }

  static clearData() async {
    secureStorage.delete(
      key: "auth",
      aOptions: _getAndroidOptions(),
    );
  }

  static setAuthData(Map<String, dynamic> data) async {
    return await secureStorage.write(
      key: "auth",
      value: jsonEncode(data),
      aOptions: _getAndroidOptions(),
    );
  }
}
