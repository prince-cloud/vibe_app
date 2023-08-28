import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:vibe_app/base.dart';
import 'package:vibe_app/local_auth.dart';
import 'package:vibe_app/screens/authentication/login.dart';
import 'package:vibe_app/screens/providers/providers.dart';

import 'screens/models/user.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final secureStorage = const FlutterSecureStorage();

  void loginUserIn() async {
    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    final String dataStr = await LocalCache.getAuthData();

    if (dataStr.isEmpty) return;

    try {
      final Map data = jsonDecode(dataStr);
      authProvider.logIn(
        token: data['access'] as String,
        isLoggedIn: true,
        user: User.fromMap(data as Map<String, dynamic>),
      );
    } catch (e) {
      return;
    }
  }

  @override
  void initState() {
    loginUserIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: true,
    );
    return authProvider.isLoggedIn ? const HomeBase() : const LoginPage();
  }
}
