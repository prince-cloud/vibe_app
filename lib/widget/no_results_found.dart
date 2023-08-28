import 'package:flutter/material.dart';

class NoResultsFound extends StatefulWidget {
  final String searchKeyWord;
  final String category;
  const NoResultsFound({
    super.key,
    required this.searchKeyWord,
    required this.category,
  });

  @override
  State<NoResultsFound> createState() => _NoResultsFoundState();
}

class _NoResultsFoundState extends State<NoResultsFound> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          widget.category.isNotEmpty
              ? "No ${widget.category} found for"
              : "No search results found for",
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          " '${widget.searchKeyWord}' ",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
