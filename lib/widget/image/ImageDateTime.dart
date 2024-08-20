import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/util/func.dart';

class ImageDateTime extends StatelessWidget {
  ImageDateTime({super.key, required this.dateTime, required this.onTap});

  DateTime dateTime;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(3.0) / 3,
        child: DT(
          padding: 5,
          backgroundColor: Colors.black,
          backgroundColorOpacity: 0.5,
          text: mdFormatter(
            locale: context.locale.toString(),
            dateTime: dateTime,
          ),
          borderRadius: 5,
          textColor: Colors.white,
          fontSize: 14,
          onTap: onTap,
        ),
      ),
    );
  }
}

class DT extends StatelessWidget {
  DT({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.borderRadius,
    required this.textColor,
    required this.fontSize,
    required this.onTap,
    this.padding,
    this.backgroundColorOpacity,
  });

  Color backgroundColor;
  double borderRadius;
  String text;
  Color textColor;
  double fontSize;
  double? padding;
  double? backgroundColorOpacity;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(backgroundColorOpacity ?? 1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: CommonText(
            text: text,
            fontSize: fontSize,
            color: textColor,
            isNotTr: true,
          ),
        ),
      ),
    );
  }
}
