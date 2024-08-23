import 'package:flutter/material.dart';

class SelectedSearchCategoryIdProvider extends ChangeNotifier {
  String selectedSearchCategoryId = '';

  void setId(String selectedId) {
    selectedSearchCategoryId = selectedId;
    notifyListeners();
  }
}
