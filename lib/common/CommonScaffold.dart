import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:provider/provider.dart';

class CommonScaffold extends StatelessWidget {
  CommonScaffold(
      {super.key,
      required this.body,
      this.appBarInfo,
      this.bottomNavigationBar,
      this.isFab,
      this.resizeToAvoidBottomInset,
      this.backgroundColor,
      this.padding,
      this.floatingActionButton});

  Widget? bottomNavigationBar;
  Widget body;
  AppBarInfoClass? appBarInfo;
  bool? resizeToAvoidBottomInset, isFab;
  Color? backgroundColor;
  EdgeInsets? padding;
  Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarInfo != null
          ? AppBar(
              foregroundColor: isLight ? Colors.black : darkTextColor,
              title: CommonText(
                text: appBarInfo!.title,
                fontSize: 16,
                isBold: !isLight,
              ),
              centerTitle: appBarInfo!.isCenter,
              actions: appBarInfo!.actions,
              backgroundColor: backgroundColor ?? Colors.transparent,
              scrolledUnderElevation: 0,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(10),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

// class Fab extends StatelessWidget {
//   Fab({super.key, required this.isFab});

//   bool? isFab;

//   @override
//   Widget build(BuildContext context) {
//     bool isLight = context.watch<ThemeProvider>().isLight;

//     return isFab == true
//         ? MultiValueListenableBuilder(
//             valueListenables: [],
//             builder: (context, values, child) {
//               DateTime selectedDateTime =
//                   context.watch<SelectedDateTimeProvider>().seletedDateTime;
//               bool isToday =
//                   dateTimeKey(DateTime.now()) == dateTimeKey(selectedDateTime);

//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [],
//               );
//             })
//         : const CommonNull();
//   }
// }

// class Bnb extends StatelessWidget {
//   Bnb({super.key, this.bnb});

//   Widget? bnb;

//   @override
//   Widget build(BuildContext context) {
//     return bnb != null
//         ? MultiValueListenableBuilder(
//             valueListenables: valueListenables,
//             builder: (context, values, child) {
//               bool isNotMonth = userRepository.user.calendarFormat !=
//                   CalendarFormat.month.toString();

//               return isNotMonth ? bnb! : const CommonNull();
//             })
//         : const CommonNull();
//   }
// }