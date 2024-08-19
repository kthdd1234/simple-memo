import 'package:flutter/material.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:provider/provider.dart';

class CommonBackground extends StatelessWidget {
  CommonBackground({
    super.key,
    required this.child,
    this.isRadius,
    this.height,
    this.borderRadius,
    this.padding,
  });

  bool? isRadius;
  double? height;
  BorderRadius? borderRadius;
  EdgeInsets? padding;
  Widget child;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Container(
      padding: padding,
      height: height ?? MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: isLight ? null : darkBgColor,
        borderRadius: borderRadius ??
            BorderRadius.circular(isRadius == true ? 10.0 : 0.0),
        image: isLight
            ? const DecorationImage(
                image: AssetImage('assets/images/texture-1.png'),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: child,
    );
  }
}
