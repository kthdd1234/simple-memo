import 'package:flutter/material.dart';
import 'package:simple_memo_app/body/MemoBody.dart';
import 'package:simple_memo_app/body/ImageBody.dart';
import 'package:simple_memo_app/body/SearchBody.dart';
import 'package:simple_memo_app/body/MoreBody.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/bottomTabIndexProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String categoryId = categoryRepository.categoryList[0].id;
      context.read<SelectedMemoCategoryIdProvider>().setId(categoryId);
    });

    super.initState();
  }

  onBottomNavigation(int? index) {
    context
        .read<BottomTabIndexProvider>()
        .changeSeletedIdx(newIndex: index ?? 0);

    String categoryId = index == 0
        ? categoryRepository.categoryList[0].id
        : index == 1
            ? 'searchAll'
            : index == 2
                ? 'imageAll'
                : '';
    context.read<SelectedMemoCategoryIdProvider>().setId(categoryId);

    if (index == 0) {
      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    int seletedIdx = context.watch<BottomTabIndexProvider>().seletedIdx;
    List<BottomNavigationBarItem> items = bottomNavigationBarItemList
        .map((item) => BottomNavigationBarItem(
              icon: item.icon,
              label: item.label!,
            ))
        .toList();

    List<Widget> bodyList = [
      const MemoBody(),
      const SearchBody(),
      const ImageBody(),
      const MoreBody()
    ];

    return CommonBackground(
      child: CommonScaffold(
        body: bodyList[seletedIdx],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: items,
            elevation: 0,
            selectedItemColor: isLight ? textColor : Colors.white,
            selectedLabelStyle: TextStyle(
              color: isLight ? orange.original : Colors.white,
              fontWeight: isLight ? null : FontWeight.bold,
            ),
            unselectedItemColor: // const Color(0xffA2A7B2)
                isLight
                    ? const Color.fromARGB(255, 115, 120, 139)
                    : const Color(0xff616261),
            unselectedLabelStyle:
                TextStyle(fontWeight: isLight ? null : FontWeight.bold),
            currentIndex: seletedIdx,
            onTap: onBottomNavigation,
          ),
        ),
      ),
    );
  }
}
