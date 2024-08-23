import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/util/final.dart';

class AppBarInfoClass {
  AppBarInfoClass({
    required this.title,
    this.isCenter,
    this.actions,
    this.isNotTr,
  });

  String title;
  bool? isCenter, isNotTr;
  List<Widget>? actions;
}

class BottomNavigationBarClass {
  BottomNavigationBarClass({
    required this.svgAsset,
    required this.index,
    required this.label,
    required this.body,
  });

  String svgAsset, label;
  int index;
  Widget body;
}

class ColorClass {
  ColorClass({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.original,
    required this.colorName,
  });

  String colorName;
  Color s50, s100, s200, s300, s400, original;
}

class CategoryClass {
  CategoryClass({
    required this.id,
    required this.name,
    required this.colorName,
  });

  String id, name, colorName;
}

class SettingItemClass {
  SettingItemClass({
    required this.name,
    required this.svg,
    required this.onTap,
    this.value,
  });

  String name, svg;
  Widget? value;
  Function() onTap;
}

class PremiumBenefitClass {
  PremiumBenefitClass({
    required this.svgName,
    required this.mainTitle,
    required this.subTitle,
  });

  String svgName, mainTitle, subTitle;
}

class WidgetHeaderClass {
  final String title, today;
  final List<int> textRGB, bgRGB;

  WidgetHeaderClass(this.title, this.today, this.textRGB, this.bgRGB);

  WidgetHeaderClass.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        today = json['today'] as String,
        textRGB = json['textRGB'] as List<int>,
        bgRGB = json['bgRGB'] as List<int>;

  Map<String, dynamic> toJson() => {
        'title': title,
        'today': today,
        'textRGB': textRGB,
        'bgRGB': bgRGB,
      };
}

class WidgetItemClass {
  final String id, name, mark;
  final List<int> barRGB, lineRGB, markRGB;
  final List<int>? highlightRGB;

  WidgetItemClass(
    this.id,
    this.name,
    this.mark,
    this.barRGB,
    this.lineRGB,
    this.markRGB,
    this.highlightRGB,
  );

  WidgetItemClass.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        mark = json['mark'] as String,
        barRGB = json['barRGB'] as List<int>,
        lineRGB = json['lineRGB'] as List<int>,
        markRGB = json['markRGB'] as List<int>,
        highlightRGB = json['highlightRGB'] as List<int>?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mark': mark,
        'barRGB': barRGB,
        'lineRGB': lineRGB,
        'markRGB': markRGB,
        'highlightRGB': highlightRGB
      };
}

class PraiseTitleClass {
  PraiseTitleClass({
    required this.id,
    required this.title,
    required this.colorName,
  });

  String id, title, colorName;
}

class MemoCategoryClass {
  MemoCategoryClass({required this.id, required this.name});

  String id, name;
}

class MemoInfoClass {
  MemoInfoClass({
    required this.categoryId,
    required this.textAlign,
    this.dateTime,
    this.imageList,
    this.memo,
  });

  String categoryId;
  TextAlign textAlign;
  List<Uint8List>? imageList;
  String? memo;
  DateTime? dateTime;
}

class ImageClass {
  ImageClass({required this.dateTime, required this.uint8List});
  DateTime dateTime;
  Uint8List uint8List;
}

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
}

class PremiumBenefitsClass {
  PremiumBenefitsClass({
    required this.svgName,
    required this.title,
    required this.subTitle,
  });

  String svgName, title, subTitle;
}
