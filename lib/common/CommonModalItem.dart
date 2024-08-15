import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:provider/provider.dart';

class CommonModalItem extends StatelessWidget {
  CommonModalItem({
    super.key,
    required this.title,
    required this.child,
    required this.onTap,
  });

  String title;
  Widget child;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: title, isBold: !isLight),
                CommonSpace(width: 50),
                child
              ],
            ),
          ),
          CommonDivider(color: isLight ? grey.s200 : Colors.white12),
        ],
      ),
    );
  }
}
