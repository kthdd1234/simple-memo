import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/func.dart';

class ModalButton extends StatelessWidget {
  ModalButton({
    super.key,
    required this.actionText,
    required this.onTap,
    this.isSelection,
    this.color,
    this.icon,
    this.svgName,
    this.innerPadding,
    this.isNotSvgColor,
    this.isNotTr,
  });

  String? svgName;
  IconData? icon;
  String actionText;
  bool? isNotTr, isNotSvgColor, isSelection;
  EdgeInsets? innerPadding;
  Color? color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color bgColor = isLight ? Colors.white : darkContainerColor;
    Color settingColor = color ?? (isLight ? themeColor : darkTextColor);

    return Expanded(
      child: Padding(
        padding: innerPadding ?? const EdgeInsets.all(0),
        child: CommonContainer(
          color: isSelection == true ? themeColor : bgColor,
          onTap: onTap,
          radius: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgName != null
                  ? svgAsset(
                      isNotColor: isNotSvgColor,
                      isLight: isLight,
                      name: svgName!,
                      width: 25,
                      color: isSelection == true ? Colors.white : settingColor,
                    )
                  : const CommonNull(),
              icon != null
                  ? Icon(
                      icon!,
                      size: 25,
                      color: isSelection == true ? Colors.white : settingColor,
                    )
                  : const CommonNull(),
              CommonSpace(height: 10),
              CommonText(
                text: actionText,
                color: isSelection == true ? Colors.white : settingColor,
                isNotTr: isNotTr,
              )
            ],
          ),
        ),
      ),
    );
  }
}
