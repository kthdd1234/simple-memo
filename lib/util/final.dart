import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_memo_app/repositories/record_repository.dart';
import 'package:simple_memo_app/repositories/user_repository.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:table_calendar/table_calendar.dart';

final bottomNavigationBarItemList = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.edit),
    label: '메모',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.view_timeline_outlined),
    label: '히스토리',
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

final valueListenables = [
  userRepository.userBox.listenable(),
  recordRepository.recordBox.listenable(),
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

final initPraiseTitleList = [
  PraiseTitleClass(
    id: '0',
    title: '칭찬 일기를 쓰기로 결심한 나',
    colorName: 'indigo',
  ),
  PraiseTitleClass(
    id: '1',
    title: '사소한 행동',
    colorName: 'indigo',
  ),
  PraiseTitleClass(
    id: '2',
    title: '나의 성격',
    colorName: 'indigo',
  ),
  PraiseTitleClass(
    id: '3',
    title: '과거에 내가 노력한 과정',
    colorName: 'indigo',
  ),
  PraiseTitleClass(
    id: '4',
    title: '내가 가지고 있는 습관',
    colorName: 'indigo',
  ),
  PraiseTitleClass(
    id: '5',
    title: '나의 외모',
    colorName: 'indigo',
  ),
  PraiseTitleClass(
    id: '6',
    title: '목표 달성',
    colorName: 'red',
  ),
  PraiseTitleClass(
    id: '6',
    title: '실패를 통해 배운 점',
    colorName: 'red',
  ),
  PraiseTitleClass(
    id: '7',
    title: '내면의 변화',
    colorName: 'red',
  ),
  PraiseTitleClass(
    id: '8',
    title: '있는 그대로의 나',
    colorName: 'red',
  ),
  PraiseTitleClass(
    id: '9',
    title: '작은 친절',
    colorName: 'blue',
  ),
  PraiseTitleClass(
    id: '10',
    title: '새로운 도전',
    colorName: 'blue',
  ),
]
    .map((item) => {
          'id': item.id,
          'title': item.title,
          'colorName': item.colorName,
        })
    .toList();

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

final groupList = [
  MemoGroupItemClass(id: '📒기본 메모', name: '📒기본 메모'),
  MemoGroupItemClass(id: '🥗다이어트', name: '🥗다이어트'),
  MemoGroupItemClass(id: '👨‍💻코딩', name: '👨‍💻코딩'),
  MemoGroupItemClass(id: '📚독서', name: '📚독서'),
  MemoGroupItemClass(id: '📝일기', name: '📝일기'),
  MemoGroupItemClass(id: '⚽️풋살', name: '⚽️풋살'),
];
