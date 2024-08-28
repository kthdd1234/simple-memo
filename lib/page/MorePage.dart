import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/etc/BackgroundPage.dart';
import 'package:simple_memo_app/page/PremiumPage.dart';
import 'package:simple_memo_app/provider/PremiumProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/etc/MoreAppBar.dart';
import 'package:simple_memo_app/widget/bottomSheet/FontBottomSheet.dart';
import 'package:simple_memo_app/widget/bottomSheet/LanguageBottomSheet.dart';
import 'package:simple_memo_app/widget/bottomSheet/ScreenModeBottomSheet.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String appVerstion = '';
  String appBuildNumber = '';

  @override
  void initState() {
    getInfo() async {
      Map<String, dynamic> appInfo = await getAppInfo();

      appVerstion = appInfo['appVerstion'];
      appBuildNumber = appInfo['appBuildNumber'];

      setState(() {});
    }

    getInfo();
    super.initState();
  }

  onPremium() {
    navigator(context: context, page: const PremiumPage());
  }

  onScreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ScreenModeBottomSheet(),
    );
  }

  onBackground() {
    navigator(context: context, page: const BackgroundPage());
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

  onPrivacy() async {
    Uri url = Uri(
      scheme: 'https',
      host: 'nettle-dill-e85.notion.site',
      path: 'eee748728b474207b2f640c910cd8a70',
      queryParameters: {'pvs': '4'},
    );

    await canLaunchUrl(url) ? await launchUrl(url) : throw 'launchUrl error';
  }

  onVersion() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '설정'),
        body: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (context, values, child) {
            UserBox user = userRepository.user;
            String background = user.background ?? '1';
            String locale = context.locale.toString();

            List<MoreItem> moreItemList = [
              MoreItem(
                svgName: 'premium-free',
                title: '프리미엄',
                value: isPremium ? '구매 완료' : '미구매',
                onMore: onPremium,
              ),
              MoreItem(
                svgName: 'screen',
                title: '화면',
                value: themesInfo[user.theme],
                onMore: onScreen,
              ),
              MoreItem(
                svgName: 'premium-backdrop',
                title: '배경',
                value: getBackgroundName(background),
                onMore: onBackground,
              ),
              MoreItem(
                svgName: 'language',
                title: '언어',
                value: localeInfo[locale],
                isNotTr: true,
                onMore: onLanguage,
              ),
              MoreItem(
                svgName: 'privacy',
                title: '개인정보처리방침',
                onMore: onPrivacy,
              ),
              MoreItem(
                svgName: 'version',
                title: '앱 버전',
                value: '$appVerstion ($appBuildNumber)',
                isNotTr: true,
                onMore: onVersion,
              ),
            ];

            return SingleChildScrollView(
              child: Column(
                children: moreItemList
                    .map((more) => MoreItem(
                          svgName: more.svgName,
                          title: more.title,
                          value: more.value,
                          isNotTr: more.isNotTr,
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
    this.isNotTr,
    this.value,
  });

  String svgName, title;
  String? value;
  bool? isNotTr;
  Function() onMore;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: onMore,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
        child: Row(
          children: [
            svgAsset(name: svgName, width: 18, isLight: isLight),
            CommonSpace(width: 15),
            CommonText(text: title, fontSize: 17),
            const Spacer(),
            value != null
                ? Row(
                    children: [
                      CommonText(
                        text: value!,
                        fontSize: 16,
                        color: isLight ? grey.original : grey.s400,
                        isNotTr: isNotTr,
                      ),
                      svgName != 'version'
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 1, left: 5),
                              child: svgAsset(
                                name: 'dir-right',
                                width: 6,
                                color: grey.original,
                                isLight: isLight,
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
