// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonPraise.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/util/enum.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:table_calendar/table_calendar.dart';

import '../util/constants.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String onCategoryBox(Map<String, String> categoryName) {
    String locale = context.locale.toString();

    String id = uuid();
    String name = categoryName[locale] ?? '📔memo';
    DateTime createDateTime = DateTime.now();

    categoryRepository.updateCategory(
      key: id,
      category: CategoryBox(
        id: id,
        name: name,
        createDateTime: createDateTime,
      ),
    );

    return id;
  }

  onStart() async {
    String categoryId1 = onCategoryBox(initCategoryName1);
    String categoryId2 = onCategoryBox(initCategoryName2);

    DateTime createDateTime = DateTime.now();
    String id = uuid();
    String fontFamily = initFontFamily;
    String calendarFormat = CalendarFormat.week.toString();
    String calendarMaker = CalendarMaker.time.toString();
    String theme = Themes.system.toString();

    userRepository.updateUser(
      UserBox(
        id: id,
        createDateTime: createDateTime,
        fontFamily: fontFamily,
        calendarFormat: calendarFormat,
        calendarMaker: calendarMaker,
        categoryOrderList: [categoryId1, categoryId2],
        theme: theme,
      ),
    );

    await Navigator.pushNamedAndRemoveUntil(
      context,
      'home-page',
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonPraise(
      titleText: '',
      buttonText: '시작하기',
      onTap: onStart,
      child: Expanded(
        child: Column(
          children: [
            const Spacer(),
            CommonText(text: '반가워요! 투데이 노트와 함께'),
            CommonText(text: '꾸준히 글쓰는 습관을 만들어봐요 :D'),
          ],
        ),
      ),
    );
  }
}
