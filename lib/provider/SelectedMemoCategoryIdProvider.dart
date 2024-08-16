import 'package:flutter/material.dart';

class SelectedMemoCategoryIdProvider extends ChangeNotifier {
  String selectedMemoCategoryId = '';

  void setId(String selectedId) {
    selectedMemoCategoryId = selectedId;
    notifyListeners();
  }
}
