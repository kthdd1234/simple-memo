import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/page/ImagePage.dart';
import 'package:simple_memo_app/page/CategoryPage.dart';
import 'package:simple_memo_app/page/MorePage.dart';
import 'package:simple_memo_app/page/SearchPage.dart';
import 'package:simple_memo_app/provider/CopyMemoInfoProvider.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/MemoAppBar.dart';
import 'package:simple_memo_app/widget/memo/MemoCalendar.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';
import 'package:simple_memo_app/widget/memo/MemoView.dart';
import 'package:table_calendar/table_calendar.dart';

class MemoBody extends StatefulWidget {
  const MemoBody({super.key});

  @override
  State<MemoBody> createState() => _MemoBodyState();
}

class _MemoBodyState extends State<MemoBody> {
  bool isCalendar = false;

  onFormatChanged(CalendarFormat calendarFormat) {
    setState(() => isCalendar = calendarFormat != CalendarFormat.month);
  }

  setCategoryId(String categoryId) {
    context.read<SelectedMemoCategoryIdProvider>().setId(categoryId);
  }

  onCalendar() {
    setState(() => isCalendar = !isCalendar);
  }

  onSearch() {
    navigator(context: context, page: const SearchPage());
  }

  onImages() {
    navigator(context: context, page: const ImagePage());
  }

  onCategory() {
    navigator(context: context, page: const CategoryPage());
  }

  onMore() {
    navigator(context: context, page: const MorePage());
  }

  @override
  Widget build(BuildContext context) {
    List<MemoCategoryClass> categoryList =
        getMemoCategoryList(categoryRepository.categoryList);
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    String categoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    Map<String, dynamic>? copyMemoInfo =
        context.watch<CopyMemoInfoProvider>().copyMemoInfo;

    return MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (context, values, child) {
          return Column(
            children: [
              MemoAppBar(
                isCalendar: isCalendar,
                onCalendar: onCalendar,
                onImages: onImages,
                onCategory: onCategory,
                onSearch: onSearch,
                onMore: onMore,
              ),
              MemoCalendar(
                  selectedDateTime: selectedDateTime,
                  categoryId: categoryId,
                  isCalendar: isCalendar,
                  onCalendar: onCalendar,
                  onFormatChanged: onFormatChanged),
              MemoView(
                selectedDateTime: selectedDateTime,
                categoryId: categoryId,
                copyMemoInfo: copyMemoInfo,
              ),
              CommonDivider(horizontal: 10, color: grey.s400),
              MemoCategoryList(categoryList: categoryList),
            ],
          );
        });
  }
}
