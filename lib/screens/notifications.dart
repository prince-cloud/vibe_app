import 'package:flutter/material.dart';
import 'package:vibe_app/components/constants.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().bgColor,
      appBar: AppBar(
        backgroundColor: CustomColors().primaryColor,
        title: Text(
          "Notifications",
          style: TextStyle(
            color: CustomColors().genericWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
