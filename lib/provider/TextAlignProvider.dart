import 'package:flutter/material.dart';
import 'package:simple_memo_app/util/final.dart';

class TextAlignProvider extends ChangeNotifier {
  TextAlign textAlign = TextAlign.left;

  initTextAlign(TextAlign align) {
    textAlign = align;
    notifyListeners();
  }

  changeTextAlign() {
    textAlign = nextTextAlign[textAlign]!;
    notifyListeners();
  }
}
