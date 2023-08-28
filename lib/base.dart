import 'package:flutter/material.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/api_services/authentication.dart';
import 'package:vibe_app/screens/homepage.dart';
import 'package:vibe_app/screens/communities.dart';
import 'package:vibe_app/screens/models/profile.dart';
import 'package:vibe_app/screens/notifications.dart';
import 'package:vibe_app/screens/profile.dart';
import 'package:vibe_app/screens/search.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const Search(),
    const GroupsCommunities(),
    const Notifications(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.bolt,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.bolt,
              color: CustomColors().primaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.search,
                color: CustomColors().primaryColor,
              ),
              label: "."),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.groups,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.groups,
                color: CustomColors().primaryColor,
              ),
              label: "."),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.notifications,
              color: CustomColors().primaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.person,
              color: CustomColors().primaryColor,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
