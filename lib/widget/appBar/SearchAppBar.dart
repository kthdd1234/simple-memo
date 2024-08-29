import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonSvg.dart';
import 'package:simple_memo_app/main.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/memo/MemoTextFormField.dart';

class SearchAppBar extends StatefulWidget {
  SearchAppBar({
    super.key,
    required this.controller,
    required this.isRecent,
    required this.onEditingComplete,
    required this.onUpDown,
  });

  TextEditingController controller;
  bool isRecent;
  Function() onEditingComplete, onUpDown;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearch = true;

  onSearch() {
    setState(() => isSearch = !isSearch);
  }

  onCancel() {
    setState(() => isSearch = false);
  }

  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        children: [
          const BackBtn(),
          Expanded(
            child: MemoTextFormField(
              autofocus: false,
              controller: widget.controller,
              textAlign: TextAlign.left,
              hintText: '키워드 검색'.tr(),
              fontSize: fontSize + 1,
              isUnderline: true,
              contentPadding: const EdgeInsets.only(bottom: 5),
              textInputAction: TextInputAction.done,
              onEditingComplete: widget.onEditingComplete,
            ),
          ),
          InkWell(
            onTap: onCancel,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 7, top: 5, bottom: 5, right: 3),
              child: CommonSvg(
                name: widget.isRecent ? 'up-down' : 'down-up',
                padding: const EdgeInsets.all(0),
                onTap: widget.onUpDown,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: () => pop(context),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 5),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: isLight ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
