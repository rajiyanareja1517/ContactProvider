import 'dart:ffi';

import 'package:flutter/material.dart';

class PlatformProvider extends ChangeNotifier {
  bool isIOS = false;

  void setIsIos() {
    this.isIOS = !isIOS;
    notifyListeners();
  }
}
