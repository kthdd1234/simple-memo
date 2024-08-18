import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/memo/MemoTextFormField.dart';

class SearchAppBar extends StatefulWidget {
  SearchAppBar({
    super.key,
    required this.controller,
    required this.isRecent,
    required this.onEditingComplete,
    required this.onUpDown,
  });

  TextEditingController controller;
  bool isRecent;
  Function() onEditingComplete, onUpDown;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool isSearch = true;

  onSearch() {
    setState(() => isSearch = !isSearch);
  }

  onCancel() {
    setState(() => isSearch = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () => pop(context),
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child:
                  Icon(Icons.arrow_back_ios_new_rounded, color: grey.original),
            ),
          ),
          Expanded(
            child: MemoTextFormField(
              autofocus: false,
              controller: widget.controller,
              textAlign: TextAlign.left,
              hintText: '메모 검색',
              fontSize: 15,
              isUnderline: true,
              contentPadding: const EdgeInsets.only(bottom: 5),
              textInputAction: TextInputAction.done,
              onEditingComplete: widget.onEditingComplete,
            ),
          ),
          InkWell(
            onTap: onCancel,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 7, top: 5, bottom: 5, right: 3),
              child: svgWidget(
                name: widget.isRecent ? 'up-down' : 'down-up',
                padding: EdgeInsets.all(0),
                onTap: widget.onUpDown,
              ),
            ),
          )
        ],
      ),
    );
    // isSearch
    //     ? SearchInputBar(
    //         controller: widget.controller,
    //         onEditingComplete: widget.onEditingComplete,
    //         onCancel: onCancel,
    //       )
    //     : Padding(
    //         padding: const EdgeInsets.only(bottom: 10),
    //         child: Column(
    //           children: [
    //             CommonAppBar(
    //               title: '검색',
    //               actions: [
    //                 svgWidget(name: 'search', onTap: onSearch),
    //                 CommonSpace(width: 10),
    //                 svgWidget(
    //                   name: widget.isRecent ? 'up-down' : 'down-up',
    //                   onTap: widget.onUpDown,
    //                 ),
    //               ],
    //             ),
    //             CommonDivider(horizontal: 10, color: grey.s400),
    //           ],
    //         ),
    //       );
  }
}

// class SearchInputBar extends StatelessWidget {
//   SearchInputBar({
//     super.key,
//     required this.controller,
//     required this.onEditingComplete,
//     required this.onCancel,
//   });

//   TextEditingController controller;
//   Function() onEditingComplete, onCancel;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
//       child: Row(
//         children: [
//           InkWell(
//             onTap: () => pop(context),
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10, bottom: 5),
//               child:
//                   Icon(Icons.arrow_back_ios_new_rounded, color: grey.original),
//             ),
//           ),
//           Expanded(
//             child: MemoTextFormField(
//               autofocus: false,
//               controller: controller,
//               textAlign: TextAlign.left,
//               hintText: '메모 검색',
//               fontSize: 15,
//               isUnderline: true,
//               contentPadding: const EdgeInsets.only(bottom: 5),
//               textInputAction: TextInputAction.done,
//               onEditingComplete: onEditingComplete,
//             ),
//           ),
//           InkWell(
//             onTap: onCancel,
//             child: Padding(
//               padding:
//                   const EdgeInsets.only(left: 7, top: 5, bottom: 5, right: 3),
//               child: svgWidget(
//                 name: widget.isRecent ? 'up-down' : 'down-up',
//                 onTap: widget.onUpDown,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
