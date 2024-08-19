import 'package:flutter/cupertino.dart';

class CopyMemoInfoProvider extends ChangeNotifier {
  Map<String, dynamic>? copyMemoInfo;

  copy(Map<String, dynamic> newMemoInfo) {
    copyMemoInfo = newMemoInfo;
    notifyListeners();
  }
}
