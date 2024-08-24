import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';

class LoadingPopup extends StatelessWidget {
  LoadingPopup({
    super.key,
    required this.text,
    required this.color,
    this.isLoadingIcon,
    this.nameArgs,
    this.subText,
  });

  String text;
  Color color;
  String? subText;
  bool? isLoadingIcon;
  Map<String, String>? nameArgs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isLoadingIcon == false
            ? const CommonNull()
            : const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
        CommonText(
          text: text,
          fontSize: 15,
          isBold: true,
          color: color,
          nameArgs: nameArgs,
        ),
        CommonSpace(height: 3),
        subText != null
            ? CommonText(
                text: subText!,
                fontSize: 11,
                isBold: true,
                color: color,
                nameArgs: nameArgs,
              )
            : const CommonNull(),
      ],
    );
  }
}
