import 'package:flutter/material.dart';
import 'package:vibe_app/widget/error_dialogue.dart';

processErrors(Map<String, dynamic> errors, BuildContext context) {
  errors.forEach((key, value) {
    String content = "";
    if (value.runtimeType == List) {
      for (dynamic i in value) {
        content = "$content $i";
      }
    } else {
      content = value.toString();
    }
    ErrorDialogue.show(context, "$key: $content");
    return;
  });
}
