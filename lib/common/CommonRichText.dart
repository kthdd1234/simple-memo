import 'package:flutter/cupertino.dart';

class CommonRichText extends StatelessWidget {
  CommonRichText({
    super.key,
    required this.startText,
    required this.targetText,
    required this.targetBgColor,
    required this.endText,
  });

  String startText, targetText, endText;
  Color targetBgColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: startText,
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: targetText,
              style: TextStyle(backgroundColor: targetBgColor),
            ),
            TextSpan(text: endText),
          ]),
    );
  }
}
