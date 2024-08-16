import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonText.dart';

class CommonAppBar extends StatelessWidget {
  CommonAppBar({super.key, required this.title, required this.actions});

  String title;
  List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(text: title, fontSize: 17, isNotTr: true),
          Row(children: actions),
        ],
      ),
    );
  }
}
