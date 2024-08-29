import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/models/offerings_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonButton.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonSvgText.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/PremiumProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/enum.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/popup/LoadingPopup.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  Package? package;

  @override
  void initState() {
    initIAP() async {
      try {
        Offerings offerings = await Purchases.getOfferings();

        List<Package>? availablePackages =
            offerings.getOffering(offeringIdentifier)?.availablePackages;

        if (availablePackages != null && availablePackages.isNotEmpty) {
          setState(() => package = availablePackages[0]);
        }
      } on PlatformException catch (e) {
        log('PlatformException =>> $e');
      }
    }

    initIAP();
    super.initState();
  }

  onPurchase() async {
    if (package != null) {
      try {
        showDialog(
          context: context,
          builder: (context) => LoadingPopup(
            text: '데이터 불러오는 중...',
            color: Colors.white,
          ),
        );

        bool isPurchaseResult = await setPurchasePremium(package!);
        context.read<PremiumProvider>().setPremiumValue(isPurchaseResult);
      } on PlatformException catch (e) {
        log('e =>> ${e.toString()}');
        PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);

        if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
          log('errorCode =>> $errorCode');
        }
      } finally {
        pop(context);
      }
    }
  }

  onRestore() async {
    bool isRestorePremium = await isPurchaseRestore();
    context.read<PremiumProvider>().setPremiumValue(isRestorePremium);
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;

    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '프리미엄 혜택'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Column(
                children: premiumBenefitsClassList
                    .map(
                      (premiumBenefit) => CommonContainer(
                        outerPadding: const EdgeInsets.only(bottom: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: svgAsset(
                                  isLight: isLight,
                                  name: premiumBenefit.svgName,
                                  width: 32.5,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(text: premiumBenefit.title),
                                  CommonText(
                                    text: premiumBenefit.subTitle,
                                    color: grey.original,
                                    fontSize: fontSize - 3,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              CommonSpace(height: 5),
              isPremium
                  ? CommonSvgText(
                      text: '구매가 완료되었어요 :D',
                      svgName: 'purchase-completed',
                      fontSize: fontSize,
                      svgWidth: fontSize - 2,
                      svgDirection: SvgDirection.left,
                    )
                  : CommonButton(
                      text: '구매하기',
                      nameArgs: {
                        'price': package?.storeProduct.priceString ?? '-'
                      },
                      textColor: Colors.white,
                      buttonColor: themeColor,
                      verticalPadding: 15,
                      borderRadius: 10,
                      onTap: onPurchase,
                    ),
              CommonSpace(height: 10),
              InkWell(
                onTap: onRestore,
                child: CommonText(
                  text: '구매 항목 복원',
                  decoration: TextDecoration.underline,
                  decorationColor: isLight ? Colors.black : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
