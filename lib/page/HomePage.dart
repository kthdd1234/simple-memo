import 'package:flutter/material.dart';
import 'package:simple_memo_app/body/MemoBody.dart';
import 'package:simple_memo_app/body/ImageBody.dart';
import 'package:simple_memo_app/body/HistoryBody.dart';
import 'package:simple_memo_app/body/MoreBody.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/bottomTabIndexProvider.dart';
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
  onBottomNavigation(int? index) {
    context
        .read<BottomTabIndexProvider>()
        .changeSeletedIdx(newIndex: index ?? 0);
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
      const HistoryBody(),
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
