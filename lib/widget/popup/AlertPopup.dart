import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonButton.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonPopup.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';

class AlertPopup extends StatelessWidget {
  AlertPopup({
    super.key,
    required this.desc,
    required this.buttonText,
    required this.height,
    required this.onTap,
  });

  double height;
  String desc, buttonText;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonPopup(
      insetPaddingHorizontal: 20,
      height: height,
      child: Column(
        children: [
          CommonContainer(
            outerPadding: const EdgeInsets.all(20),
            child: CommonText(text: desc, isBold: !isLight),
          ),
          CommonDivider(),
          CommonButton(
            text: buttonText,
            outerPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            textColor: Colors.white,
            buttonColor: isLight ? textColor : darkButtonColor,
            verticalPadding: 15,
            borderRadius: 7,
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
