// ignore_for_file: unused_local_variable, prefer_const_declarations

import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';
import 'package:simple_memo_app/widget/popup/AlertPopup.dart';
import 'package:table_calendar/table_calendar.dart';

SvgPicture svgAsset({
  required bool isLight,
  required String name,
  required double width,
  Color? color,
  bool? isNotColor,
}) {
  if (isNotColor == true) {
    return SvgPicture.asset('assets/svgs/$name.svg', width: width);
  }

  return SvgPicture.asset(
    'assets/svgs/$name.svg',
    width: width,
    colorFilter: ColorFilter.mode(
        color ?? (isLight ? Colors.black : Colors.white), BlendMode.srcIn),
  );
}

String ymdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMd(locale).format(dateTime);
}

String ymdFullFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMMd(locale).format(dateTime);
}

String mdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMEd(locale).format(dateTime);
}

String mdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMd(locale).format(dateTime);
}

String ymdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMEd(locale).format(dateTime);
}

String ymdeShortFormatter(
    {required String locale, required DateTime dateTime}) {
  return DateFormat.yMEd(locale).format(dateTime);
}

String ymdeFullFormatter({
  required String locale,
  required DateTime dateTime,
}) {
  return DateFormat.yMMMMEEEEd(locale).format(dateTime);
}

String yMFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMM(locale).format(dateTime);
}

String yFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.y(locale).format(dateTime);
}

String dFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.d(locale).format(dateTime);
}

String eFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.E(locale).format(dateTime);
}

String eeeeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.EEEE(locale).format(dateTime);
}

String hmFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.jm(locale).format(dateTime);
}

ColorClass getColorClass(String? name) {
  if (name == null) {
    return indigo;
  }

  return colorList.firstWhere((info) => info.colorName == name);
}

void pop(context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

int ymdToInt(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

int dateTimeKey(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

String uuid() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}

Future<Map<String, dynamic>> getAppInfo() async {
  PackageInfo info = await PackageInfo.fromPlatform();

  return {
    "appVerstion": info.version,
    'appBuildNumber': info.buildNumber,
  };
}

navigator({required BuildContext context, required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (BuildContext context) => page),
  );
}

fadeNavigator({required BuildContext context, required Widget page}) {
  Navigator.push(context, FadePageRoute(page: page));
}

// ad: banner, native, appOpening
String getAdId(String ad) {
  final platform = Platform.isIOS ? 'ios' : 'android';
  final env = kDebugMode ? 'debug' : 'real';
  final adId = {
    'android': {
      'banner': {
        'debug': androidBannerTestId,
        'real': androidBannerRealId,
      },
      'native': {
        'debug': androidNativeTestId,
        'real': androidNativeRealId,
      },
      'appOpening': {
        'debug': androidAppOpeningTestId,
        'real': androidAppOpeningRealId,
      }
    },
    'ios': {
      'banner': {
        'debug': iOSBannerTestId,
        'real': iOSBannerRealId,
      },
      'native': {
        'debug': iOSNativeTestId,
        'real': iOSNativeRealId,
      },
      'appOpening': {
        'debug': iOSAppOpeningTestId,
        'real': iOSAppOpeningRealId,
      }
    },
  };

  return adId[platform]![ad]![env]!;
}

Future<bool> setPurchasePremium(Package package) async {
  try {
    CustomerInfo customerInfo = await Purchases.purchasePackage(package);
    return customerInfo.entitlements.all[entitlementIdentifier]?.isActive ==
        true;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

Future<bool> isPurchasePremium() async {
  try {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    bool isActive =
        customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;
    return isActive;
    // return true;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

Future<bool> isPurchaseRestore() async {
  try {
    CustomerInfo customerInfo = await Purchases.restorePurchases();
    bool isActive =
        customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;
    return isActive;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

bool isEmptyRecord(RecordBox? record) {
  return false;
}

DateTime weeklyStartDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime;
  }

  return dateTime.subtract(Duration(days: dateTime.weekday));
}

DateTime weeklyEndDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime.add(const Duration(days: 6));
  }

  return dateTime.add(Duration(
    days: DateTime.daysPerWeek - dateTime.weekday - 1,
  ));
}

calendarHeaderStyle(bool isLight) {
  return HeaderStyle(
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: isLight ? Colors.black : Colors.white,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    formatButtonVisible: false,
    leftChevronIcon: Icon(
      Icons.chevron_left,
      color: isLight ? buttonColor : Colors.white,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right,
      color: isLight ? buttonColor : Colors.white,
    ),
  );
}

calendarDaysOfWeekStyle(bool isLight) {
  return DaysOfWeekStyle(
    weekdayStyle: TextStyle(
      fontSize: 15,
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    weekendStyle: TextStyle(
      fontSize: 15,
      color: red.s300,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
  );
}

calendarDetailStyle(bool isLight) {
  return CalendarStyle(
    defaultTextStyle: TextStyle(
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    weekendTextStyle: TextStyle(
      color: isLight ? Colors.black : red.s300,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    todayDecoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    todayTextStyle: TextStyle(
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    outsideDaysVisible: false,
  );
}

String getMemoCategoryName(String categoryId) {
  return categoryRepository.categoryBox.get(categoryId)?.name ?? '';
}

// List<MemoInfoClass> getMemoInfoList(List<Map<String, dynamic>> memoInfoList) {
//   return recordRepository.recordList.where((record) => ).toList();
// }

MemoInfoClass? getMemoInfo(DateTime dateTime, String categoryId) {
  int recordKey = dateTimeKey(dateTime);
  RecordBox? record = recordRepository.recordBox.get(recordKey);
  List<Map<String, dynamic>> memoInfoList = record?.memoInfoList ?? [];
  int index =
      memoInfoList.indexWhere((info) => info['categoryId'] == categoryId);

  return index != -1 ? memoInfoToClass(memoInfoList[index]) : null;
}

Map<String, dynamic> memoInfoToMap(MemoInfoClass memoInfo) {
  return {
    'categoryId': memoInfo.categoryId,
    'imageList': memoInfo.imageList,
    'memo': memoInfo.memo,
    'textAlign': memoInfo.textAlign.toString(),
  };
}

MemoInfoClass memoInfoToClass(Map<String, dynamic> memoInfo) {
  return MemoInfoClass(
    categoryId: memoInfo['categoryId'],
    imageList: getImageList(memoInfo['imageList']),
    textAlign: textAlignInfo[memoInfo['textAlign']]!,
    memo: memoInfo['memo'],
  );
}

List<Uint8List>? getImageList(List<dynamic>? uint8ListList) {
  if (uint8ListList == null) return null;
  return uint8ListList.map((data) => data as Uint8List).toList();
}

onPaste({
  required BuildContext context,
  required DateTime selectedDateTime,
  required String selectedCategoryId,
  Map<String, dynamic>? copyMemoInfo,
}) async {
  int recordKey = dateTimeKey(selectedDateTime);
  RecordBox? record = recordRepository.recordBox.get(recordKey);
  List<Map<String, dynamic>> memoInfoList = record?.memoInfoList ?? [];

  if (copyMemoInfo == null) {
    showDialog(
      context: context,
      builder: (context) => AlertPopup(
        desc: '복사한 글이 없어요.',
        buttonText: '확인',
        height: 150,
        onTap: () => pop(context),
      ),
    );
  } else {
    int index = memoInfoList
        .indexWhere((info) => info['categoryId'] == selectedCategoryId);

    if (index == -1) {
      copyMemoInfo['categoryId'] = selectedCategoryId;

      recordRepository.updateRecord(
        key: recordKey,
        record: RecordBox(
          createDateTime: selectedDateTime,
          memoInfoList: [...memoInfoList, copyMemoInfo],
        ),
      );
    } else {
      memoInfoList[index]['categoryId'] = selectedCategoryId;
      memoInfoList[index]['imageList'] = copyMemoInfo['imageList'];
      memoInfoList[index]['memo'] = copyMemoInfo['memo'];
      memoInfoList[index]['textAlign'] = copyMemoInfo['textAlign'];

      await record?.save();
    }
  }

  pop(context);
}

removeMemoInfo({
  required BuildContext context,
  required DateTime selectedDateTime,
  required String selectedCategoryId,
}) async {
  int recordKey = dateTimeKey(selectedDateTime);
  RecordBox? record = recordRepository.recordBox.get(recordKey);
  List<Map<String, dynamic>> memoInfoList = record?.memoInfoList ?? [];
  int index = memoInfoList
      .indexWhere((info) => info['categoryId'] == selectedCategoryId);

  memoInfoList.removeAt(index);

  await record?.save();
  pop(context);
}

List<CategoryBox> getCategoryList() {
  List<String> categoryOrderList = userRepository.user.categoryOrderList;
  List<CategoryBox> categoryList = categoryRepository.categoryList;

  categoryList.sort((a, b) {
    int index1 = categoryOrderList.indexOf(a.id);
    int index2 = categoryOrderList.indexOf(b.id);

    return index1.compareTo(index2);
  });

  return categoryList;
}
