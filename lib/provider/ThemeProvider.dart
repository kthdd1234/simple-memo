import 'package:flutter/material.dart';
import 'package:simple_memo_app/util/final.dart';

class ThemeProvider with ChangeNotifier {
  String theme = tLight;

  setThemeValue(String newValue) {
    theme = newValue;
    notifyListeners();
  }

  bool get isLight => theme == tLight;
}
