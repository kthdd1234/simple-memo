import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_memo_app/repositories/category_repository.dart';
import 'package:simple_memo_app/repositories/record_repository.dart';
import 'package:simple_memo_app/repositories/user_repository.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/enum.dart';
import 'package:table_calendar/table_calendar.dart';

final bottomNavigationBarItemList = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.edit),
    label: '글',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search_rounded),
    label: '검색',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.image_outlined),
    label: '사진',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.more_horiz_rounded),
    label: '더보기',
  )
];

final indigo = ColorClass(
  colorName: '남색',
  original: Colors.indigo, // 63, 81, 181
  s50: Colors.indigo.shade50, // 232, 234, 246
  s100: Colors.indigo.shade100, // 197, 202, 233
  s200: Colors.indigo.shade200, // 159, 168, 218
  s300: Colors.indigo.shade300, // 255, 121, 134, 203
  s400: Colors.indigo.shade400,
);

final green = ColorClass(
  colorName: '녹색',
  original: Colors.green,
  s50: Colors.green.shade50,
  s100: Colors.green.shade100,
  s200: Colors.green.shade200, // 165, 214, 167
  s300: Colors.green.shade300,
  s400: Colors.green.shade400,
); //

final teal = ColorClass(
  colorName: '청록색',
  original: Colors.teal,
  s50: Colors.teal.shade50,
  s100: Colors.teal.shade100, // 178, 223, 219
  s200: Colors.teal.shade200, // 128, 203, 196
  s300: Colors.teal.shade300, // 255, 77, 182, 172
  s400: Colors.teal.shade400,
); //

final red = ColorClass(
  colorName: '빨간색',
  original: Colors.red,
  s50: Colors.red.shade50,
  s100: Colors.red.shade100, // 255, 205, 210
  s200: Colors.red.shade200, // 239, 154, 154
  s300: Colors.red.shade300, // 229, 115, 115
  s400: Colors.red.shade400,
); //

final pink = ColorClass(
  colorName: '핑크색',
  original: Colors.pink,
  s50: Colors.pink.shade50,
  s100: Colors.pink.shade100,
  s200: Colors.pink.shade200,
  s300: Colors.pink.shade300,
  s400: Colors.pink.shade400,
); //

final blue = ColorClass(
  colorName: '파란색',
  original: Colors.blue, // 33, 150, 243
  s50: Colors.blue.shade50, // 227, 242, 253
  s100: Colors.blue.shade100, // 187, 222, 251
  s200: Colors.blue.shade200, // 144, 202, 249
  s300: Colors.blue.shade300, // 100, 181, 246
  s400: Colors.blue.shade400, // 66, 165, 245
); //

final brown = ColorClass(
  colorName: '갈색',
  original: Colors.brown,
  s50: Colors.brown.shade50,
  s100: Colors.brown.shade100,
  s200: Colors.brown.shade200,
  s300: Colors.brown.shade300,
  s400: Colors.brown.shade400,
); //

final orange = ColorClass(
  colorName: '주황색',
  original: Colors.orange,
  s50: Colors.orange.shade50,
  s100: Colors.orange.shade100, // 255, 224, 178
  s200: Colors.orange.shade200, // 255, 204, 128
  s300: Colors.orange.shade300,
  s400: Colors.orange.shade400,
); //

final purple = ColorClass(
  colorName: '보라색',
  original: Colors.purple,
  s50: Colors.purple.shade50,
  s100: Colors.purple.shade100, // 225, 190, 231
  s200: Colors.purple.shade200, // 206, 147, 216
  s300: Colors.purple.shade300,
  s400: Colors.purple.shade400,
); //

final grey = ColorClass(
  colorName: '회색',
  original: Colors.grey.shade600,
  s50: Colors.grey.shade50,
  s100: Colors.grey.shade100,
  s200: Colors.grey.shade200,
  s300: Colors.grey.shade300,
  s400: Colors.grey.shade400,
); //

final lime = ColorClass(
  colorName: '라임색',
  original: Colors.lime,
  s50: Colors.lime.shade50,
  s100: Colors.lime.shade100,
  s200: Colors.lime.shade200,
  s300: Colors.lime.shade300,
  s400: Colors.lime.shade400,
); //

final cyan = ColorClass(
  colorName: '민트색',
  original: Colors.cyan,
  s50: Colors.cyan.shade50,
  s100: Colors.cyan.shade100,
  s200: Colors.cyan.shade200, // 128, 222, 234
  s300: Colors.cyan.shade300,
  s400: Colors.cyan.shade400, // 38, 198, 218
); //

final ember = ColorClass(
  colorName: '노랑색',
  original: Colors.amber,
  s50: Colors.amber.shade50,
  s100: Colors.amber.shade100,
  s200: Colors.amber.shade200,
  s300: Colors.amber.shade300,
  s400: Colors.amber.shade400,
); //

final blueGrey = ColorClass(
  colorName: '청회색',
  original: Colors.blueGrey,
  s50: Colors.blueGrey.shade50,
  s100: Colors.blueGrey.shade100, // 207, 216, 200
  s200: Colors.blueGrey.shade200, // 176, 190, 197
  s300: Colors.blueGrey.shade300,
  s400: Colors.blueGrey.shade400,
); //

final lightBlue = ColorClass(
  colorName: 'lightBlue',
  original: Colors.lightBlue,
  s50: Colors.lightBlue.shade50,
  s100: Colors.lightBlue.shade100,
  s200: Colors.lightBlue.shade200,
  s300: Colors.lightBlue.shade300,
  s400: Colors.lightBlue.shade400,
);

final colorList = [
  indigo,
  red,
  pink,
  green,
  teal,
  blue,
  brown,
  orange,
  purple,
  blueGrey
];

final calendarFormatInfo = {
  CalendarFormat.week.toString(): CalendarFormat.week,
  CalendarFormat.month.toString(): CalendarFormat.month,
};

final availableCalendarFormats = {
  CalendarFormat.week: 'week',
  CalendarFormat.month: 'month',
};

const nextCalendarFormats = {
  CalendarFormat.week: CalendarFormat.month,
  CalendarFormat.month: CalendarFormat.week
};

UserRepository userRepository = UserRepository();
RecordRepository recordRepository = RecordRepository();
CategoryRepository categoryRepository = CategoryRepository();

final valueListenables = [
  userRepository.userBox.listenable(),
  recordRepository.recordBox.listenable(),
  categoryRepository.categoryBox.listenable()
];

final premiumBenefitList = [
  PremiumBenefitClass(
    svgName: 'premium-free',
    mainTitle: '평생 무료로 이용 할 수 있어요',
    subTitle: '커피 한잔의 가격으로 단 한번 결제!',
  ),
  PremiumBenefitClass(
    svgName: 'premium-no-ads',
    mainTitle: '모든 화면에서 광고가 나오지 않아요',
    subTitle: '광고없이 쾌적하게 앱을 사용해보세요!',
  ),
];

final daysInfo = {
  '일': 7,
  '월': 1,
  '화': 2,
  '수': 3,
  '목': 4,
  '금': 5,
  '토': 6,
  0: 7,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
};

Map<TextAlign, TextAlign> nextTextAlign = {
  TextAlign.left: TextAlign.center,
  TextAlign.center: TextAlign.right,
  TextAlign.right: TextAlign.left
};

Map<TextAlign, String> textAlignName = {
  TextAlign.left: 'left',
  TextAlign.center: 'center',
  TextAlign.right: 'right'
};

// final categoryList = [
//   MemoCategoryClass(id: '📒기본 메모', name: '📒기본 메모'),
//   MemoCategoryClass(id: '🥗다이어트', name: '🥗다이어트'),
//   MemoCategoryClass(id: '👨‍💻코딩', name: '👨‍💻코딩'),
//   MemoCategoryClass(id: '📚독서', name: '📚독서'),
//   MemoCategoryClass(id: '📝일기', name: '📝일기'),
//   MemoCategoryClass(id: '⚽️풋살', name: '⚽️풋살'),
// ];

List<Map<String, String>> fontFamilyList = [
  {
    "fontFamily": "Omyu",
    "name": "오뮤 다예쁨체",
  },
  {
    "fontFamily": "IM_Hyemin",
    "name": "IM 혜민",
  },
  {
    "fontFamily": "KyoboHandwriting2019",
    "name": "교보 손글씨",
  },
  {
    "fontFamily": "SingleDay",
    "name": "싱글데이",
  },
  {
    "fontFamily": "Cafe24Dongdong",
    "name": "카페24 동동",
  },
  {
    "fontFamily": "Cafe24Syongsyong",
    "name": "카페24 숑숑",
  },
  {
    "fontFamily": "Cafe24Ssukssuk",
    "name": "카페24 쑥쑥",
  },
];

final languageList = [
  {'svgName': 'korea', 'lang': 'ko', 'name': '한국어'},
  {'svgName': 'usa', 'lang': 'en', 'name': 'English'},
  {'svgName': 'japan', 'lang': 'ja', 'name': '日本語'},
];

Map<String, String> initCategoryName1 = {
  'ko': '📔노트 1',
  'en': '📔note 1',
  'ja': '📔タイトル1'
};
Map<String, String> initCategoryName2 = {
  'ko': '📕노트 2',
  'en': '📕note 2',
  'ja': '📕タイトル2'
};

final textAlignInfo = {
  TextAlign.left.toString(): TextAlign.left,
  TextAlign.right.toString(): TextAlign.right,
  TextAlign.center.toString(): TextAlign.center,
};

final alignmentInfo = {
  TextAlign.left: Alignment.topLeft,
  TextAlign.center: Alignment.topCenter,
  TextAlign.right: Alignment.topRight,
};

final crossAxisAlignmentInfo = {
  TextAlign.left: CrossAxisAlignment.start,
  TextAlign.center: CrossAxisAlignment.center,
  TextAlign.right: CrossAxisAlignment.end,
};

String tSystem = Themes.system.toString();
String tLight = Themes.light.toString();
String tDark = Themes.dark.toString();

final themesInfo = {tSystem: '시스템 설정', tLight: '화이트 모드', tDark: '다크 모드'};

final localeInfo = {'en': 'English', 'ko': '한국어', 'ja': '日本語'};
