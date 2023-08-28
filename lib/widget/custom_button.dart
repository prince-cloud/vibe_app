import 'package:flutter/material.dart';
import 'package:vibe_app/components/constants.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Function()? onTap;
  final String text;
  Color? bgColor;
  Color? textColor;
  CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              6,
            ),
            color: bgColor ?? CustomColors().primaryColor,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor ?? CustomColors().genericWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
