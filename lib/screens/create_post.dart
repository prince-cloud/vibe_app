import 'package:flutter/material.dart';
import 'package:vibe_app/components/constants.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().bgColor,
      appBar: AppBar(
        backgroundColor: CustomColors().primaryColor,
        title: Text(
          "Whats' Happening",
          style: TextStyle(
            color: CustomColors().genericWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
