import 'package:flutter/material.dart';

enum Door { front, back, left, right }

class HomeController extends ChangeNotifier {
  Map<Door, bool> doorStatus = {
    Door.right: false,
    Door.left: false,
    Door.front: false,
    Door.back: false,
  };

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updateThebottomSheetIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void updateDoorStatus(Door door) {
    doorStatus[door] = !(doorStatus[door] ?? false);

    notifyListeners();
  }

  bool isDoorLocked(Door status) {
    return doorStatus[status] ?? false;
  }
}
