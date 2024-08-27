import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/util/constants.dart';

class SearchMemo extends StatelessWidget {
  SearchMemo({super.key, this.text, required this.textAlign});

  String? text;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CommonText(
              text: text!,
              fontSize: defaultFontSize + 1,
              isNotTr: true,
              textAlign: textAlign,
            ),
          )
        : const CommonNull();
  }
}
