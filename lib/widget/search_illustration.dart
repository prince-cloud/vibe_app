import 'package:flutter/material.dart';

class SearchIllustration extends StatefulWidget {
  final String text;
  const SearchIllustration({super.key, required this.text});

  @override
  State<SearchIllustration> createState() => _SearchIllustrationState();
}

class _SearchIllustrationState extends State<SearchIllustration> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Image.asset(
            "assets/images/search_illustration.png",
          ),
        ),
        Text(
          widget.text,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
