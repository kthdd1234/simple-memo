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
    required this.textAlign,
    this.focusNode,
    this.fontSize,
    this.autofocus,
    this.onEditingComplete,
    this.textInputAction,
    this.hintText,
    this.contentPadding,
    this.isUnderline,
    this.maxLength,
    this.focusedBorderColor,
  });

  TextEditingController controller;
  TextAlign textAlign;
  String? hintText;
  double? fontSize;
  bool? autofocus;
  FocusNode? focusNode;
  TextInputAction? textInputAction;
  EdgeInsets? contentPadding;
  bool? isUnderline;
  int? maxLength;
  Color? focusedBorderColor;
  Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autofocus ?? true,
      maxLines: null,
      maxLength: maxLength,
      minLines: null,
      cursorColor: textColor,
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
        hintText: hintText ?? '메모를 입력해주세요 :D'.tr(),
        hintStyle: TextStyle(color: grey.s400),
        border: isUnderline != true ? InputBorder.none : null,
        enabledBorder: isUnderline == true
            ? UnderlineInputBorder(borderSide: BorderSide(color: grey.s400))
            : null,
        focusedBorder: isUnderline == true
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor ?? textColor),
              )
            : null,
      ),
      onEditingComplete: onEditingComplete,
    );
  }
}
