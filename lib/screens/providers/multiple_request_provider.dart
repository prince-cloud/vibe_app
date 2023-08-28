import 'package:flutter/material.dart';

class CreateMultipleOrderProvider extends ChangeNotifier {
  List requests = [];

  saveReqeust({required Map<String, dynamic> pickUpObject}) {
    requests.add(pickUpObject);
    notifyListeners();
  }

  clear() {
    requests.clear();
    notifyListeners();
  }

  removeItem(int id) {
    requests.removeAt(id);
    notifyListeners();
  }
}
