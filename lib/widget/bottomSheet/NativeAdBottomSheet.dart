import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/page/PremiumPage.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class NativeAdBottomSheet extends StatefulWidget {
  NativeAdBottomSheet({super.key, required this.isLight});

  bool isLight;

  @override
  State<NativeAdBottomSheet> createState() => _NativeAdBottomSheetState();
}

class _NativeAdBottomSheetState extends State<NativeAdBottomSheet> {
  NativeAd? nativeAd;
  bool isLoaded = false;

  @override
  void initState() {
    if (isLoaded == false) {
      nativeAd = loadNativeAd(
        isLight: widget.isLight,
        adUnitId: getAdId('native'),
        onAdLoaded: () {
          setState(() => isLoaded = true);
        },
        onAdFailedToLoad: () {
          setState(() {
            isLoaded = false;
            nativeAd = null;
          });
        },
      );
    }

    super.initState();
  }

  onPremium() {
    pop(context);
    navigator(context: context, page: const PremiumPage());
  }

  onClose() {
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String categoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    bool isLight = context.watch<ThemeProvider>().isLight;

    final recordList = recordRepository.recordList.where((record) {
      final memoInfoList = record.memoInfoList ?? [];

      for (var i = 0; i < memoInfoList.length; i++) {
        final memoInfo = memoInfoList[i];

        if (memoInfo['categoryId'] == categoryId) {
          return true;
        }
      }

      return false;
    });

    return CommonModalSheet(
      title: '👏🏻일째 기록했어요!',
      nameArgs: {'length': '${recordList.length}'},
      height: 460,
      isClose: true,
      child: CommonContainer(
        color: Colors.transparent,
        innerPadding: const EdgeInsets.all(0),
        child: isLoaded == false
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: isLight ? Colors.black : Colors.white,
                ),
              )
            : AdWidget(ad: nativeAd!),
      ),
    );
  }
}
