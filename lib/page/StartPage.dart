// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonPraise.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/repositories/category_repository.dart';
import 'package:simple_memo_app/repositories/user_repository.dart';
import 'package:simple_memo_app/util/enum.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:table_calendar/table_calendar.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String onCategoryBox() {
    String locale = context.locale.toString();

    String id = uuid();
    String name = initCategoryName[locale] ?? '📔memo';
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

  onUserBox(String categoryId) async {
    DateTime createDateTime = DateTime.now();
    String id = uuid();
    String fontFamily = 'IM_Hyemin';
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
        categoryOrderList: [categoryId],
        theme: theme,
      ),
    );

    // await UserRepository().user.save();
  }

  onStart() async {
    String categoryId = onCategoryBox();
    onUserBox(categoryId);

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
            CommonText(text: '반가워요! 심플 메모 앱과 함께'),
            CommonText(text: '꾸준히 메모하는 습관을 만들어봐요:D'),
          ],
        ),
      ),
    );
  }
}
