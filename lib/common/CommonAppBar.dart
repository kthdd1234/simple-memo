import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonSvgText.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/util/enum.dart';

class CommonAppBar extends StatelessWidget {
  CommonAppBar({
    super.key,
    required this.title,
    required this.actions,
    this.isNotTr,
    this.svgName,
    this.svgWidth,
    this.svgLeft,
    this.svgDirection,
    this.onTap,
  });

  String title;
  bool? isNotTr;
  String? svgName;
  double? svgWidth, svgLeft;
  SvgDirection? svgDirection;
  List<Widget> actions;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonSvgText(
          text: title,
          fontSize: 20,
          isNotTr: isNotTr,
          svgName: svgName,
          svgWidth: svgWidth ?? 10,
          svgLeft: svgLeft,
          svgDirection: svgDirection ?? SvgDirection.right,
          outerPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
          onTap: onTap,
        ),
        Row(children: actions),
      ],
    );
  }
}
