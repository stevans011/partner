import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int itemIndex = 0;

  void changeItem(int index) {
    itemIndex = index;
    notifyListeners();
  }
}
