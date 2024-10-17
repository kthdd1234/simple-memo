import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSvg.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/widget/memo/MemoTextFormField.dart';

class SearchAppBar extends StatelessWidget {
  SearchAppBar({
    super.key,
    required this.controller,
    required this.isSearch,
    required this.isRecent,
    required this.onEditingComplete,
    required this.onUpDown,
    required this.onSearch,
    required this.onCancel,
  });

  TextEditingController controller;
  bool isRecent, isSearch;
  Function() onEditingComplete, onUpDown, onSearch, onCancel;

  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: isSearch ? 5 : 10),
            child: Row(
              children: [
                isSearch
                    ? Expanded(
                        child: MemoTextFormField(
                          autofocus: true,
                          controller: controller,
                          textAlign: TextAlign.left,
                          hintText: '키워드 검색'.tr(),
                          fontSize: fontSize + 1,
                          contentPadding: const EdgeInsets.only(bottom: 5),
                          textInputAction: TextInputAction.done,
                          onEditingComplete: onEditingComplete,
                        ),
                      )
                    : CommonText(text: '검색'),
                isSearch ? const CommonNull() : const Spacer(),
                isSearch
                    ? const CommonNull()
                    : CommonSvg(
                        name: 'search',
                        padding: const EdgeInsets.only(right: 10),
                        onTap: onSearch,
                      ),
                isSearch
                    ? InkWell(
                        onTap: onCancel,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Icon(
                            Icons.highlight_remove,
                            color: grey.s400,
                            size: 18,
                          ),
                        ),
                      )
                    : const CommonNull(),
                CommonSvg(
                  name: isRecent ? 'up-down' : 'down-up',
                  padding: const EdgeInsets.all(0),
                  onTap: onUpDown,
                )
              ],
            ),
          ),
          CommonDivider()
        ],
      ),
    );
  }
}
