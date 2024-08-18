// import 'package:flutter/material.dart';
// import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
// import 'package:simple_memo_app/common/CommonNull.dart';
// import 'package:simple_memo_app/common/CommonSpace.dart';
// import 'package:simple_memo_app/common/CommonText.dart';
// import 'package:simple_memo_app/util/final.dart';
// import 'package:simple_memo_app/util/func.dart';
// import 'package:simple_memo_app/widget/appBar/MoreAppBar.dart';
// import 'package:simple_memo_app/widget/bottomSheet/FontBottomSheet.dart';
// import 'package:simple_memo_app/widget/bottomSheet/LanguageBottomSheet.dart';
// import 'package:simple_memo_app/widget/bottomSheet/ScreenModeBottomSheet.dart';

// class MoreBody extends StatefulWidget {
//   const MoreBody({super.key});

//   @override
//   State<MoreBody> createState() => _MoreBodyState();
// }

// class _MoreBodyState extends State<MoreBody> {
//   onScreen() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => const ScreenModeBottomSheet(),
//     );
//   }

//   onLanguage() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => const LanguageBottomSheet(),
//     );
//   }

//   onFont() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => const FontBottomSheet(),
//     );
//   }

//   onPrivacy() {
//     //
//   }

//   onVersion() {
//     //
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<MoreItem> moreItemList = [
//       MoreItem(
//         svgName: 'screen',
//         title: '화면',
//         value: '시스템 설정',
//         onMore: onScreen,
//       ),
//       MoreItem(
//         svgName: 'language',
//         title: '언어',
//         value: 'English',
//         onMore: onLanguage,
//       ),
//       MoreItem(
//         svgName: 'font',
//         title: '글꼴',
//         value: 'IM 혜민',
//         onMore: onFont,
//       ),
//       MoreItem(
//         svgName: 'privacy',
//         title: '개인정보처리방침',
//         onMore: onPrivacy,
//       ),
//       MoreItem(
//         svgName: 'version',
//         title: '앱 버전',
//         value: '1.0.1',
//         onMore: onVersion,
//       ),
//     ];

//     return MultiValueListenableBuilder(
//       valueListenables: valueListenables,
//       builder: (context, values, child) {
//         return Column(
//           children: [
//             const MoreAppBar(),
//             SingleChildScrollView(
//               child: Column(
//                 children: moreItemList
//                     .map((more) => MoreItem(
//                           svgName: more.svgName,
//                           title: more.title,
//                           value: more.value,
//                           onMore: more.onMore,
//                         ))
//                     .toList(),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
