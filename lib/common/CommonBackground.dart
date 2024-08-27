import 'package:flutter/material.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/util/final.dart';

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
    String background =
        userRepository.isUser ? userRepository.user.background ?? '1' : '1';

    return Container(
      padding: padding,
      height: height ?? MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: isLight ? null : darkBgColor,
        borderRadius: borderRadius ??
            BorderRadius.circular(isRadius == true ? 10.0 : 0.0),
        image: isLight
            ? DecorationImage(
                image: AssetImage('assets/images/texture-$background.png'),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: child,
    );
  }
}
