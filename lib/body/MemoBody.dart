import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/page/ImagePage.dart';
import 'package:simple_memo_app/page/CategoryPage.dart';
import 'package:simple_memo_app/page/MemoPage.dart';
import 'package:simple_memo_app/page/MorePage.dart';
import 'package:simple_memo_app/page/SearchPage.dart';
import 'package:simple_memo_app/provider/CopyMemoInfoProvider.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/MemoAppBar.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoPasteBottomSheet.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoSettingBottomSheet.dart';
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

  onMemo(MemoInfoClass? memoInfo) {
    fadeNavigator(context: context, page: MemoPage(initMemoInfo: memoInfo));
  }

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

  onTag(String selectedId) {
    context.read<SelectedMemoCategoryIdProvider>().setId(selectedId);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    String categoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    Map<String, dynamic>? copyMemoInfo =
        context.watch<CopyMemoInfoProvider>().copyMemoInfo;

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        MemoInfoClass? memoInfo = getMemoInfo(selectedDateTime, categoryId);

        onHorizontalDrag(DragEndDetails dragEndDetails) {
          List<CategoryBox> categoryList = getCategoryList();
          double? primaryVelocity = dragEndDetails.primaryVelocity;
          int index = categoryList.indexWhere(
            (category) => category.id == categoryId,
          );

          if (index != -1) {
            if (primaryVelocity == null) {
              return;
            } else if (primaryVelocity > 0) {
              index -= 1;

              if (index > -1) {
                String beforeCategoryId = categoryList[index].id;

                context
                    .read<SelectedMemoCategoryIdProvider>()
                    .setId(beforeCategoryId);
              }
            } else if (primaryVelocity < 0) {
              index += 1;

              if (index < categoryList.length) {
                String afterCategoryId = categoryList[index].id;

                context
                    .read<SelectedMemoCategoryIdProvider>()
                    .setId(afterCategoryId);
              }
            }
          }
        }

        onLongPress() {
          if (memoInfo != null) {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => MemoSettingBottomSheet(
                memoInfo: memoInfo,
                copyMemoInfo: copyMemoInfo,
                selectedCategoryId: categoryId,
                selectedDateTime: selectedDateTime,
              ),
            );
          } else if (copyMemoInfo != null) {
            showModalBottomSheet(
              context: context,
              builder: (context) => MemoPasteBottomSheet(
                copyMemoInfo: copyMemoInfo,
                selectedCategoryId: categoryId,
                selectedDateTime: selectedDateTime,
              ),
            );
          }
        }

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
            memoInfo != null
                ? Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraint.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  MemoCalendar(
                                    isLight: isLight,
                                    selectedDateTime: selectedDateTime,
                                    categoryId: categoryId,
                                    isCalendar: isCalendar,
                                    onCalendar: onCalendar,
                                    onFormatChanged: onFormatChanged,
                                  ),
                                  MemoCategoryList(
                                    categoryId: categoryId,
                                    categoryList: getCategoryList(),
                                    onTag: onTag,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onLongPress: onLongPress,
                                      onHorizontalDragEnd: onHorizontalDrag,
                                      child: MemoView(
                                        selectedDateTime: selectedDateTime,
                                        categoryId: categoryId,
                                        memoInfo: memoInfo,
                                        copyMemoInfo: copyMemoInfo,
                                        onMemo: onMemo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        MemoCalendar(
                          isLight: isLight,
                          selectedDateTime: selectedDateTime,
                          categoryId: categoryId,
                          isCalendar: isCalendar,
                          onCalendar: onCalendar,
                          onFormatChanged: onFormatChanged,
                        ),
                        MemoCategoryList(
                          categoryId: categoryId,
                          categoryList: getCategoryList(),
                          onTag: onTag,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onLongPress: onLongPress,
                            onHorizontalDragEnd: onHorizontalDrag,
                            child: InkWell(
                              onTap: () => onMemo(null),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: CommonText(
                                    text: '+ 글쓰기',
                                    color: isLight ? grey.original : grey.s400,
                                    fontSize: defaultFontSize + 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }
}
