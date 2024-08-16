import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonText.dart';

class SearchMemo extends StatelessWidget {
  const SearchMemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: CommonText(
        text: '얄리얄리얄랴성 얄리얄리 얄라',
        fontSize: 13,
        isNotTr: true,
      ),
    );
  }
}
