import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_memo_app/common/CommonBannerAd.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/page/CategoryPage.dart';
import 'package:simple_memo_app/etc/MemoPage.dart';
import 'package:simple_memo_app/provider/CopyMemoInfoProvider.dart';
import 'package:simple_memo_app/provider/PremiumProvider.dart';
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
  ItemScrollController? controller = ItemScrollController();
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

  onCategory() {
    navigator(context: context, page: const CategoryPage());
  }

  onTag(String selectedId) {
    context.read<SelectedMemoCategoryIdProvider>().setId(selectedId);
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    String categoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    Map<String, dynamic>? copyMemoInfo =
        context.watch<CopyMemoInfoProvider>().copyMemoInfo;

    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    onMemo(MemoInfoClass? memoInfo) async {
      await Navigator.push(
        context,
        FadePageRoute(page: MemoPage(initMemoInfo: memoInfo)),
      );
    }

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        MemoInfoClass? memoInfo = getMemoInfo(selectedDateTime, categoryId);

        onHorizontalDrag(DragEndDetails dragEndDetails) {
          double? primaryVelocity = dragEndDetails.primaryVelocity;

          if (primaryVelocity == null) {
            return;
          } else if (primaryVelocity > 0) {
            selectedDateTime =
                selectedDateTime.subtract(const Duration(days: 1));
          } else if (primaryVelocity < 0) {
            selectedDateTime = selectedDateTime.add(const Duration(days: 1));
          }

          context
              .read<SelectedDateTimeProvider>()
              .changeSelectedDateTime(dateTime: selectedDateTime);
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
              onCategory: onCategory,
            ),
            Expanded(
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
                            Expanded(
                              child: GestureDetector(
                                onLongPress: onLongPress,
                                onHorizontalDragEnd: onHorizontalDrag,
                                child: memoInfo != null
                                    ? MemoView(
                                        selectedDateTime: selectedDateTime,
                                        categoryId: categoryId,
                                        memoInfo: memoInfo,
                                        copyMemoInfo: copyMemoInfo,
                                        onMemo: onMemo,
                                      )
                                    : InkWell(
                                        onTap: () => onMemo(null),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.touch_app_rounded,
                                                color: isLight
                                                    ? grey.original
                                                    : grey.s400,
                                              ),
                                              CommonSpace(height: 5),
                                              CommonText(
                                                text: '화면을 터치해서\n글을 써보세요',
                                                color: isLight
                                                    ? grey.original
                                                    : grey.s400,
                                                fontSize: fontSize,
                                              ),
                                            ],
                                          ),
                                        ),
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
            ),
            !isPremium ? const CommonBannerAd() : const CommonNull(),
            MemoCategoryList(
              controller: controller,
              categoryId: categoryId,
              categoryList: getCategoryList(),
              onTag: onTag,
            ),
          ],
        );
      },
    );
  }
}
