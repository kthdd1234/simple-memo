import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simple_memo_app/page/HomePage.dart';
import 'package:simple_memo_app/page/StartPage.dart';
import 'package:simple_memo_app/provider/HistoryOrderProvider.dart';
import 'package:simple_memo_app/provider/KeywordProvider.dart';
import 'package:simple_memo_app/provider/PremiumProvider.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/TextAlignProvider.dart';
import 'package:simple_memo_app/provider/TitleDateTimeProvider.dart';
import 'package:simple_memo_app/provider/YearDateTimeProvider.dart';
import 'package:simple_memo_app/provider/bottomTabIndexProvider.dart';
import 'package:simple_memo_app/provider/reload_provider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/repositories/init_hive.dart';
import 'package:simple_memo_app/repositories/user_repository.dart';
// import 'package:simple_memo_app/repositories/init_hive.dart';
// import 'package:simple_memo_app/repositories/user_repository.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();
  await InitHive().initializeHive();
  // await Purchases.configure(_configuration);
  // await MobileAds.instance.initialize();
  // await HomeWidget.setAppGroupId('group.todo-planner-widget');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider()),
        ChangeNotifierProvider(create: (context) => SelectedDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => TitleDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => PremiumProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => YearDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => HistoryOrderProvider()),
        ChangeNotifierProvider(create: (context) => KeywordProvider()),
        ChangeNotifierProvider(create: (context) => ReloadProvider()),
        ChangeNotifierProvider(create: (context) => TextAlignProvider()),
        ChangeNotifierProvider(
            create: (context) => SelectedMemoCategoryIdProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ko'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool isUser = UserRepository().isUser;
    String initialRoute = isUser ? 'home-page' : 'start-page';

    return MaterialApp(
      title: 'praise diary',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: initFontFamily,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        'home-page': (context) => const HomePage(),
        'start-page': (context) => const StartPage()
      },
    );
  }
}
