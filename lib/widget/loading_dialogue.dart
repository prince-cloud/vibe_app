import 'package:flutter/material.dart';
import 'package:vibe_app/components/constants.dart';

class LoadingDialog extends StatefulWidget {
  final String? message;
  const LoadingDialog({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.15,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: CustomColors().genericWhite,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: CustomColors().primaryColor,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.message ?? "Please Wait ...",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
