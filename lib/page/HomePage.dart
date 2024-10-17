import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/body/ImageBody.dart';
import 'package:simple_memo_app/body/MemoBody.dart';
import 'package:simple_memo_app/body/MoreBody.dart';
import 'package:simple_memo_app/body/SearchBody.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/bottomTabIndexProvider.dart';
import 'package:simple_memo_app/provider/PremiumProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/util/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppLifecycleReactor _appLifecycleReactor;

  initialzeAppOpening() {
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(
      appOpenAdManager: appOpenAdManager,
    );
    _appLifecycleReactor.listenToAppStateChanges();
  }

  initializeDB() {
    UserBox? user = userRepository.user;

    if (mounted) {
      user.background ??= '1';
      user.isNoteUnderline ??= false;
      user.fontSize ??= defaultFontSize;
    }
  }

  initializePremium() async {
    bool isPremium = await isPurchasePremium();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PremiumProvider>().setPremiumValue(isPremium);
    });
  }

  initializeCategoryList() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List<CategoryBox> categoryList = getCategoryList();
      context.read<SelectedMemoCategoryIdProvider>().setId(categoryList[0].id);
    });
  }

  onBottomNavigation(int newIndex) {
    DateTime now = DateTime.now();

    if (newIndex == 0) {
      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: now);
      // context.read<TitleDateTimeProvider>().changeTitleDateTime(dateTime: now);
    }

    context.read<BottomTabIndexProvider>().changeSeletedIdx(newIndex: newIndex);
  }

  @override
  void initState() {
    initialzeAppOpening();
    initializeDB();
    initializePremium();
    initializeCategoryList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    int currentIndex = context.watch<BottomTabIndexProvider>().seletedIdx;

    svg(int idx, String name) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: svgAsset(
          isLight: isLight,
          name: name,
          width: 20,
          color: idx == currentIndex
              ? isLight
                  ? Colors.black
                  : Colors.white
              : grey.s400,
        ),
      );
    }

    List<BNClass> bnList = [
      BNClass(index: 0, name: '기록', icon: svg(0, 'pencil')),
      BNClass(index: 1, name: '검색', icon: svg(1, 'search')),
      BNClass(index: 2, name: '사진', icon: svg(2, 'image')),
      BNClass(index: 3, name: '설정', icon: svg(3, 'setting'))
    ];

    List<BottomNavigationBarItem> bnbItemList = bnList
        .map(
          (bn) => BottomNavigationBarItem(label: bn.name.tr(), icon: bn.icon),
        )
        .toList();

    Widget body = [
      const MemoBody(),
      const SearchBody(),
      const ImageBody(),
      const MoreBody(),
    ][currentIndex];

    return CommonBackground(
      child: CommonScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: body,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: BottomNavigationBar(
            items: bnbItemList,
            elevation: 0,
            selectedItemColor: isLight ? Colors.black : Colors.white,
            selectedLabelStyle: TextStyle(
              color: isLight ? Colors.black : Colors.white,
              fontWeight: isLight ? null : FontWeight.bold,
              fontSize: defaultFontSize - 2,
            ),
            unselectedItemColor: grey.s400,
            unselectedLabelStyle: TextStyle(
              fontWeight: isLight ? null : FontWeight.bold,
              fontSize: defaultFontSize - 2,
            ),
            currentIndex: currentIndex,
            onTap: onBottomNavigation,
          ),
        ),
      ),
    );
  }
}
