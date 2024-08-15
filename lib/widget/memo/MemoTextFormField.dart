import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';

class MemoTextFormField extends StatelessWidget {
  MemoTextFormField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.cursorColor,
    this.focusNode,
    required this.textAlign,
    this.fontSize,
    this.autofocus,
    this.onEditingComplete,
    this.textInputAction,
    this.hintText,
    this.contentPadding,
  });

  TextEditingController controller;
  TextAlign textAlign;
  String? hintText;
  double? fontSize;
  bool? autofocus;
  FocusNode? focusNode;
  TextInputAction? textInputAction;
  EdgeInsets? contentPadding;
  Color? cursorColor;
  Function(String) onChanged;
  Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autofocus ?? true,
      maxLines: null,
      minLines: null,
      cursorColor: cursorColor,
      textInputAction: textInputAction ?? TextInputAction.newline,
      style: TextStyle(
        fontSize: fontSize,
        color: isLight ? Colors.black : darkTextColor,
        fontWeight: isLight ? FontWeight.normal : FontWeight.bold,
      ),
      textAlign: textAlign,
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        isDense: true,
        border: InputBorder.none,
        hintText: hintText ?? '메모를 입력해주세요 :D'.tr(),
        hintStyle: TextStyle(color: grey.s400),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
