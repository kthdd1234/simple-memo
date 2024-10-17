// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
// import 'package:simple_memo_app/common/CommonBackground.dart';
// import 'package:simple_memo_app/common/CommonScaffold.dart';
// import 'package:simple_memo_app/common/CommonSpace.dart';
// import 'package:simple_memo_app/model/category_box/category_box.dart';
// import 'package:simple_memo_app/util/final.dart';
// import 'package:simple_memo_app/util/func.dart';
// import 'package:simple_memo_app/widget/appBar/SearchAppBar.dart';
// import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';
// import 'package:simple_memo_app/widget/search/SearchView.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController keywordController = TextEditingController();
//   bool isRecent = true;
//   String categoryId = 'all';

//   onEditingComplete() {
//     FocusScope.of(context).unfocus();
//   }

//   onUpDown() {
//     setState(() => isRecent = !isRecent);
//   }

//   onTag(String selectedId) {
//     setState(() => categoryId = selectedId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<CategoryBox> categoryList = getCategoryList();

//     categoryList.insert(
//       0,
//       CategoryBox(
//         id: 'all',
//         name: '전체'.tr(),
//         createDateTime: DateTime.now(),
//       ),
//     );

//     return CommonBackground(
//       child: CommonScaffold(
//         body: MultiValueListenableBuilder(
//           valueListenables: valueListenables,
//           builder: (context, values, child) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SearchAppBar(
//                   controller: keywordController,
//                   isRecent: isRecent,
//                   onEditingComplete: onEditingComplete,
//                   onUpDown: onUpDown,
//                 ),
//                 MemoCategoryList(
//                   categoryId: categoryId,
//                   categoryList: categoryList,
//                   onTag: onTag,
//                 ),
//                 CommonSpace(height: 10),
//                 SearchView(
//                   isRecent: isRecent,
//                   keyword: keywordController.text,
//                   categoryId: categoryId,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
