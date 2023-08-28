import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_app/main_auth_check.dart';
import 'package:vibe_app/screens/providers/auth_provider.dart';
import 'package:vibe_app/screens/providers/community_provider.dart';
import 'package:vibe_app/screens/providers/group_provider.dart';

import 'screens/providers/post_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (context) => PostProvider()..fetchNewPosts(),
        ),
        ChangeNotifierProvider<GroupProvider>(
          create: (context) => GroupProvider()..fetchNewGroups(),
        ),
        ChangeNotifierProvider<CommunitProvider>(
          create: (context) => CommunitProvider()..fetchNewCommunities(),
        ),
      ],
      child: MaterialApp(
        title: 'VIBE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthCheck(),
      ),
    );
  }
}
