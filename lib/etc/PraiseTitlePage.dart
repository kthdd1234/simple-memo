// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:simple_memo_app/common/CommonContainer.dart';
// import 'package:simple_memo_app/common/CommonPraise.dart';
// import 'package:simple_memo_app/common/CommonSpace.dart';
// import 'package:simple_memo_app/common/CommonTag.dart';
// import 'package:simple_memo_app/common/CommonText.dart';
// import 'package:simple_memo_app/etc/PraiseIntroPage.dart';
// import 'package:simple_memo_app/util/final.dart';

// class PraiseTitlePage extends StatelessWidget {
//   const PraiseTitlePage({super.key});

//   onNext() {
//     //
//   }

//   @override
//   Widget build(BuildContext context) {
//     final praiseTitleList = [
//       '칭찬 일기를 쓰기로 결심한 나에게 칭찬하기',
//       '나의 성격에 대해 칭찬하기',
//       '과거에 내가 노력한 과정 칭찬하기',
//       '내가 가지고 있는 습관 칭찬하기'
//     ];

//     return CommonPraise(
//       titleText: '칭찬 일기 주제',
//       onTap: onNext,
//       buttonText: '다음 (2/3)',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 PraiseText(text: '칭찬 일기 쓰는 습관을 만들기 위해'),
//                 PraiseText(
//                   text: '2주간 칭찬 주제에 맞게 쓰는 것을 추천드려요.',
//                   isLast: true,
//                 ),
//               ],
//             ),
//           ),
//           CommonContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CommonTag(
//                   text: '칭찬 주제 리스트',
//                   textColor: indigo.original,
//                   bgColor: indigo.s50,
//                   onTap: () {},
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(
//                     praiseTitleList.length,
//                     (index) => Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: CommonText(
//                         text: 'Day ${index + 1}. ${praiseTitleList[index]}',
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: Column(
//                       children: [
//                         Icon(Icons.circle, size: 5, color: grey.s400),
//                         CommonSpace(height: 5),
//                         Icon(Icons.circle, size: 5, color: grey.s400),
//                         CommonSpace(height: 5),
//                         Icon(Icons.circle, size: 5, color: grey.s400),
//                       ],
//                     ),
//                   ),
//                 ),
//                 CommonText(
//                   text: 'Day 14. 2주간 칭찬 일기를 쓴 나에게 칭찬하기',
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
