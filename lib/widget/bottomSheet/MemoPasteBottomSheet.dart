import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class MemoPasteBottomSheet extends StatelessWidget {
  MemoPasteBottomSheet({
    super.key,
    this.copyMemoInfo,
    required this.selectedDateTime,
    required this.selectedCategoryId,
  });

  DateTime selectedDateTime;
  String selectedCategoryId;
  Map<String, dynamic>? copyMemoInfo;

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      height: 120,
      child: GestureDetector(
        onTap: () => onPaste(
          context: context,
          selectedCategoryId: selectedCategoryId,
          selectedDateTime: selectedDateTime,
          copyMemoInfo: copyMemoInfo,
        ),
        child: CommonContainer(
          child: Row(
            children: [
              svgAsset(name: 'paste', width: 19),
              CommonSpace(width: 15),
              CommonText(text: '메모 붙어넣기')
            ],
          ),
        ),
      ),
    );
  }
}
