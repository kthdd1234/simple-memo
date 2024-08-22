import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/func.dart';

class CommonSvg extends StatelessWidget {
  CommonSvg({
    super.key,
    required this.name,
    required this.onTap,
    required this.padding,
  });

  String name;
  EdgeInsets padding;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: svgAsset(name: name, width: 21, isLight: isLight),
      ),
    );
  }
}
