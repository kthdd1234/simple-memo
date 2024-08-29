import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';

class SearchMemo extends StatelessWidget {
  SearchMemo({super.key, this.text, required this.textAlign});

  String? text;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    return text != null
        ? Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CommonText(
              text: text!,
              fontSize: fontSize + 1,
              isNotTr: true,
              textAlign: textAlign,
            ),
          )
        : const CommonNull();
  }
}
