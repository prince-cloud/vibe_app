import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vibe_app/local_auth.dart';
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/models/user.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  bool isLoggedIn = false;
  User? user;
  bool? isMapCreated;

  Future<void> loadAuthData() async {
    final String dataStr = await LocalCache.getAuthData();
    if (dataStr.isEmpty) return;
    try {
      final Map data = jsonDecode(dataStr);
      logIn(
        token: data['access'] as String,
        isLoggedIn: true,
        user: User.fromMap(data as Map<String, dynamic>),
      );
    } catch (e, s) {
      print(s);
      print(e);
      print("Decoding cached authentication data failed.");
    }
  }

  logIn({required String token, required bool isLoggedIn, required User user}) {
    this.token = token;
    this.isLoggedIn = isLoggedIn;
    this.user = user;
    serviceHeaders['Authorization'] = "Bearer ${this.token}";
    notifyListeners();
  }

  logOut() {
    serviceHeaders['Authorization'] = "";
    user = null;
    isLoggedIn = false;
    LocalCache.clearData();
    notifyListeners();
  }

  setMapCreated({required bool isMapCreated}) {
    this.isMapCreated = isMapCreated;
    notifyListeners();
  }

  updateUser({required User user}) {
    this.user = user;
    notifyListeners();
  }

  // whoamI() async {
  //   user = await AuthService().whoamI();
  //   notifyListeners();
  // }
}
