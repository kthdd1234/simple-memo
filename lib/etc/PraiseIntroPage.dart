// import 'package:flutter/cupertino.dart';
// import 'package:simple_memo_app/common/CommonContainer.dart';
// import 'package:simple_memo_app/common/CommonPraise.dart';
// import 'package:simple_memo_app/common/CommonRichText.dart';
// import 'package:simple_memo_app/common/CommonSpace.dart';
// import 'package:simple_memo_app/common/CommonTag.dart';
// import 'package:simple_memo_app/common/CommonText.dart';
// import 'package:simple_memo_app/etc/PraiseTitlePage.dart';
// import 'package:simple_memo_app/util/final.dart';
// import 'package:simple_memo_app/util/func.dart';

// class PraiseIntroPage extends StatefulWidget {
//   const PraiseIntroPage({super.key});

//   @override
//   State<PraiseIntroPage> createState() => _PraiseIntroPageState();
// }

// class _PraiseIntroPageState extends State<PraiseIntroPage> {
//   onNext() {
//     navigator(context: context, page: PraiseTitlePage());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CommonPraise(
//       titleText: '칭찬 일기 쓰는 법',
//       buttonText: '다음 (1/3)',
//       onTap: onNext,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // PraiseText(text: '칭찬 일기를 쓰는 법은 간단해요.'),
//                 // PraiseText(text: '평소에 다른 사람에게 칭찬 하는 것처럼'),
//                 // PraiseText(text: '나에게 칭찬하면 돼요!', isLast: true),
//               ],
//             ),
//           ),
//           CommonContainer(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CommonTag(
//                   text: '예시 1',
//                   textColor: blue.original,
//                   bgColor: blue.s50,
//                   onTap: () {},
//                 ),
//                 CommonSpace(height: 10),
//                 CommonRichText(
//                   startText: '다이어트를 위해 매일 아침/점심/저녁 식단을 기록하고 꾸준히 운동을 하는 ',
//                   targetText: ' 내가 정말 대단해!',
//                   targetBgColor: blue.s50,
//                   endText: ' 지금처럼만 한다면 다음 달에 목표 몸무게에 도달할 수 있을 거야!',
//                 )
//               ],
//             ),
//           ),
//           CommonSpace(height: 10),
//           CommonContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CommonTag(
//                   text: '예시 2',
//                   textColor: green.original,
//                   bgColor: teal.s50,
//                   onTap: () {},
//                 ),
//                 CommonSpace(height: 10),
//                 CommonRichText(
//                   startText:
//                       '취업 준비를 열심히 하고 있지만 좀처럼 좋은 결과가 나오지 않네. 하지만 열심히 여기저기에 이력서를 넣고 있는 ',
//                   targetText: ' 내가 씩씩하고 멋져!',
//                   targetBgColor: green.s50,
//                   endText: ' 반드시 좋은 결과가 있을거야. 걱정할 필요 없어.',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PraiseText extends StatelessWidget {
//   PraiseText({super.key, required this.text, this.isLast});

//   String text;
//   bool? isLast;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: isLast == true ? 0 : 2),
//       child: CommonText(text: text, fontSize: 15),
//     );
//   }
// }
