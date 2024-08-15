import 'package:flutter/material.dart';

class SelectedMemoCategoryIdProvider extends ChangeNotifier {
  String selectedMemoCategoryId = '📒기본 메모';

  void setId(String selectedId) {
    selectedMemoCategoryId = selectedId;
    notifyListeners();
  }
}
