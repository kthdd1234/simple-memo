import 'package:flutter/material.dart';

class SelectedImageCategoryIdProvider extends ChangeNotifier {
  String selectedImageCategoryId = '';

  void setId(String selectedId) {
    selectedImageCategoryId = selectedId;
    notifyListeners();
  }
}
