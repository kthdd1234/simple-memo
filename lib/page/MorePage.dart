import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/MoreAppBar.dart';
import 'package:simple_memo_app/widget/bottomSheet/FontBottomSheet.dart';
import 'package:simple_memo_app/widget/bottomSheet/LanguageBottomSheet.dart';
import 'package:simple_memo_app/widget/bottomSheet/ScreenModeBottomSheet.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  onScreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ScreenModeBottomSheet(),
    );
  }

  onLanguage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  onFont() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const FontBottomSheet(),
    );
  }

  onPrivacy() {
    //
  }

  onVersion() {
    //
  }

  @override
  Widget build(BuildContext context) {
    List<MoreItem> moreItemList = [
      MoreItem(
        svgName: 'screen',
        title: '화면',
        value: '시스템 설정',
        onMore: onScreen,
      ),
      MoreItem(
        svgName: 'language',
        title: '언어',
        value: 'English',
        onMore: onLanguage,
      ),
      MoreItem(
        svgName: 'font',
        title: '글꼴',
        value: 'IM 혜민',
        onMore: onFont,
      ),
      MoreItem(
        svgName: 'privacy',
        title: '개인정보처리방침',
        onMore: onPrivacy,
      ),
      MoreItem(
        svgName: 'version',
        title: '앱 버전',
        value: '1.0.1',
        onMore: onVersion,
      ),
    ];

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '설정'),
        body: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (context, values, child) {
            return SingleChildScrollView(
              child: Column(
                children: moreItemList
                    .map((more) => MoreItem(
                          svgName: more.svgName,
                          title: more.title,
                          value: more.value,
                          onMore: more.onMore,
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MoreItem extends StatelessWidget {
  MoreItem({
    super.key,
    required this.svgName,
    required this.title,
    required this.onMore,
    this.value,
  });

  String svgName, title;
  String? value;
  Function() onMore;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onMore,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
        child: Row(
          children: [
            svgAsset(name: svgName, width: 18),
            CommonSpace(width: 15),
            CommonText(text: title, fontSize: 17),
            const Spacer(),
            value != null
                ? Row(
                    children: [
                      CommonText(
                        text: value!,
                        fontSize: 16,
                        color: grey.original,
                      ),
                      svgName != 'version'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 2, left: 5),
                              child: svgAsset(
                                name: 'dir-right',
                                width: 6,
                                color: grey.original,
                              ),
                            )
                          : const CommonNull()
                    ],
                  )
                : const CommonNull(),
          ],
        ),
      ),
    );
  }
}
