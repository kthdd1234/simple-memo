import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/page/MemoPage.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class SearchItemBottomSheet extends StatelessWidget {
  SearchItemBottomSheet({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    onEdit() {
      pop(context);

      navigator(context: context, page: MemoPage());
    }

    onRemove() {
      pop(context);
    }

    return CommonModalSheet(
      title: title,
      height: 185,
      child: Row(
        children: [
          ModalButton(svgName: 'pencil', actionText: '수정하기', onTap: onEdit),
          CommonSpace(width: 10),
          ModalButton(svgName: 'trash', actionText: '삭제하기', onTap: onRemove),
        ],
      ),
    );
  }
}
