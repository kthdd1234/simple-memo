import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonOutlineInputField.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/memo/MemoTextFormField.dart';

class MemoCategoryBottomSheet extends StatefulWidget {
  const MemoCategoryBottomSheet({super.key});

  @override
  State<MemoCategoryBottomSheet> createState() =>
      _MemoCategoryBottomSheetState();
}

class _MemoCategoryBottomSheetState extends State<MemoCategoryBottomSheet> {
  TextEditingController controller = TextEditingController();

  onEditingComplete() {
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '카테고리 추가',
        height: 145,
        child: CommonContainer(
          child: MemoTextFormField(
            autofocus: true,
            controller: controller,
            textAlign: TextAlign.left,
            hintText: '카테고리를 입력해주세요.',
            maxLength: 30,
            isUnderline: true,
            focusedBorderColor: grey.s400,
            contentPadding: const EdgeInsets.only(bottom: 5),
            textInputAction: TextInputAction.done,
            onEditingComplete: onEditingComplete,
          ),
        ),
      ),
    );
  }
}
