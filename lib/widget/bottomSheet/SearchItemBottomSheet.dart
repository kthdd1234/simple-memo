import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/page/MemoPage.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class SearchItemBottomSheet extends StatelessWidget {
  SearchItemBottomSheet({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    onEdit() {
      pop(context);

      navigator(
        context: context,
        page: MemoPage(initTextAlign: TextAlign.left),
      );
    }

    onRemove() {
      pop(context);
    }

    return CommonModalSheet(
      title: title,
      height: 185,
      child: Row(
        children: [
          ModalButton(
            svgName: 'pencil',
            actionText: '수정하기',
            isBold: !isLight,
            color: isLight ? textColor : darkTextColor,
            onTap: onEdit,
          ),
          CommonSpace(width: 10),
          ModalButton(
            svgName: 'trash',
            actionText: '삭제하기',
            isBold: !isLight,
            color: red.original,
            onTap: onRemove,
          ),
        ],
      ),
    );
  }
}
