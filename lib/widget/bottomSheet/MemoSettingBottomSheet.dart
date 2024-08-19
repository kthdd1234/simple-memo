import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/page/HomePage.dart';
import 'package:simple_memo_app/provider/CopyMemoInfoProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class MemoSettingBottomSheet extends StatefulWidget {
  MemoSettingBottomSheet({
    super.key,
    required this.memoInfo,
    required this.selectedDateTime,
    required this.selectedCategoryId,
    this.copyMemoInfo,
  });

  MemoInfoClass memoInfo;
  DateTime selectedDateTime;
  String selectedCategoryId;
  Map<String, dynamic>? copyMemoInfo;

  @override
  State<MemoSettingBottomSheet> createState() => _MemoSettingBottomSheetState();
}

class _MemoSettingBottomSheetState extends State<MemoSettingBottomSheet> {
  onCopy() {
    context.read<CopyMemoInfoProvider>().copy(memoInfoToMap(widget.memoInfo));
    pop(context);
  }

  onRemove() async {
    int recordKey = dateTimeKey(widget.selectedDateTime);
    RecordBox? record = recordRepository.recordBox.get(recordKey);
    List<Map<String, dynamic>> memoInfoList = record?.memoInfoList ?? [];
    int index = memoInfoList
        .indexWhere((info) => info['categoryId'] == widget.memoInfo.categoryId);

    memoInfoList.removeAt(index);

    await record?.save();
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      height: 150,
      child: Row(
        children: [
          ModalButton(svgName: 'copy', actionText: '메모 복사', onTap: onCopy),
          CommonSpace(width: 5),
          ModalButton(
            svgName: 'paste',
            actionText: '메모 붙여넣기',
            onTap: () => onPaste(
              context: context,
              selectedDateTime: widget.selectedDateTime,
              selectedCategoryId: widget.selectedCategoryId,
              copyMemoInfo: widget.copyMemoInfo,
            ),
          ),
          CommonSpace(width: 5),
          ModalButton(
              svgName: 'trash',
              actionText: '메모 삭제',
              color: red.s400,
              onTap: onRemove),
        ],
      ),
    );
  }
}
