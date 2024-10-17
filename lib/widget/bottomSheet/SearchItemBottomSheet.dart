import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/etc/MemoPage.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class SearchItemBottomSheet extends StatelessWidget {
  SearchItemBottomSheet({
    super.key,
    required this.title,
    required this.memoInfo,
  });

  String title;
  MemoInfoClass memoInfo;

  @override
  Widget build(BuildContext context) {
    String selectedCategoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;

    onEdit() {
      pop(context);
      navigator(context: context, page: MemoPage(initMemoInfo: memoInfo));
    }

    return CommonModalSheet(
      title: title,
      isNotTr: true,
      height: 192,
      child: Row(
        children: [
          ModalButton(
            svgName: 'pencil',
            actionText: '수정하기',
            onTap: onEdit,
          ),
          CommonSpace(width: 10),
          ModalButton(
            svgName: 'trash',
            actionText: '삭제하기',
            color: red.s400,
            onTap: () => removeMemoInfo(
              context: context,
              selectedDateTime: memoInfo.dateTime!,
              selectedCategoryId: selectedCategoryId,
            ),
          ),
        ],
      ),
    );
  }
}
