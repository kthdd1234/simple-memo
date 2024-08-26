import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonButton.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';

class CommonPraise extends StatelessWidget {
  CommonPraise({
    super.key,
    required this.titleText,
    required this.child,
    required this.buttonText,
    required this.onTap,
  });

  String titleText, buttonText;
  Widget child;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        appBarInfo: AppBarInfoClass(title: titleText),
        body: Column(
          children: [
            child,
            const Spacer(),
            CommonButton(
              text: buttonText,
              textColor: isLight ? Colors.black : Colors.white,
              buttonColor: isLight ? Colors.white : darkButtonColor,
              verticalPadding: 15,
              isBold: false,
              borderRadius: 7,
              onTap: onTap,
            )
          ],
        ),
      ),
    );
  }
}
