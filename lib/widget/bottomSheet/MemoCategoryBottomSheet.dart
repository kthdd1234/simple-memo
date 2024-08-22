import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonOutlineInputField.dart';
import 'package:simple_memo_app/main.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/memo/MemoTextFormField.dart';

class MemoCategoryBottomSheet extends StatefulWidget {
  MemoCategoryBottomSheet({super.key, this.initCategoryBox});

  CategoryBox? initCategoryBox;

  @override
  State<MemoCategoryBottomSheet> createState() =>
      _MemoCategoryBottomSheetState();
}

class _MemoCategoryBottomSheetState extends State<MemoCategoryBottomSheet> {
  TextEditingController controller = TextEditingController();

  onEditingComplete() async {
    if (widget.initCategoryBox == null) {
      String id = uuid();

      categoryRepository.categoryBox.put(
        id,
        CategoryBox(
          id: id,
          name: controller.text,
          createDateTime: DateTime.now(),
        ),
      );

      userRepository.user.categoryOrderList.add(id);
      await userRepository.user.save();
    } else {
      CategoryBox? categoryBox =
          categoryRepository.categoryBox.get(widget.initCategoryBox!.id);
      categoryBox?.name = controller.text;

      await categoryBox?.save();
    }

    pop(context);
  }

  @override
  void initState() {
    if (widget.initCategoryBox != null) {
      controller.text = widget.initCategoryBox!.name;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '노트 ${widget.initCategoryBox != null ? '편집' : '추가'}',
        height: 132.5,
        child: CommonContainer(
          outerPadding: const EdgeInsets.only(bottom: 10),
          child: MemoTextFormField(
            autofocus: true,
            controller: controller,
            fontSize: defaultFontSize,
            textAlign: TextAlign.left,
            hintText: '노트 이름을 입력해주세요.'.tr(),
            isUnderline: true,
            maxLength: 30,
            focusedBorderColor: Colors.transparent,
            textInputAction: TextInputAction.done,
            onEditingComplete: onEditingComplete,
          ),
        ),
      ),
    );
  }
}
