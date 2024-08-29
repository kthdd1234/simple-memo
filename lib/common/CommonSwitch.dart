import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/util/final.dart';

class CommonSwitch extends StatelessWidget {
  CommonSwitch({
    super.key,
    required this.activeColor,
    required this.value,
    required this.onChanged,
  });

  Color activeColor;
  bool value;
  Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CupertinoSwitch(
      trackColor: isLight ? null : darkNotSelectedBgColor,
      activeColor: isLight ? activeColor : grey.s300,
      value: value,
      onChanged: onChanged,
    );
  }
}
