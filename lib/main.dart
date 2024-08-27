import 'dart:developer';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/page/HomePage.dart';
import 'package:simple_memo_app/page/StartPage.dart';
import 'package:simple_memo_app/provider/CopyMemoInfoProvider.dart';
import 'package:simple_memo_app/provider/PremiumProvider.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
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
import 'package:simple_memo_app/util/final.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final purchasesConfiguration =
    PurchasesConfiguration(Platform.isIOS ? appleApiKey : googleApiKey);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();
  await InitHive().initializeHive();
  await Purchases.configure(purchasesConfiguration);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    print("Failed to initialize Firebase: $e");
  }
  // await MobileAds.instance.initialize();
  // await HomeWidget.setAppGroupId('group.todo-planner-widget');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomTabIndexProvider()),
        ChangeNotifierProvider(create: (context) => SelectedDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => PremiumProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ReloadProvider()),
        ChangeNotifierProvider(create: (context) => CopyMemoInfoProvider()),
        ChangeNotifierProvider(
          create: (context) => SelectedMemoCategoryIdProvider(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Box<UserBox>? userBox;

  setTheme() {
    UserBox? user = userBox?.get('userProfile');
    String theme = user?.theme ?? tSystem;
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    context.read<ThemeProvider>().setThemeValue(
          theme == tSystem
              ? brightness == Brightness.light
                  ? tLight
                  : tDark
              : theme,
        );
  }

  appTrackingTransparency() async {
    try {
      TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } on PlatformException {
      log('error');
    }
  }

  @override
  void initState() {
    userBox = Hive.box('userBox');

    appTrackingTransparency();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setTheme());
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    bool isForeground = state == AppLifecycleState.resumed;
    if (isForeground) setTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ReloadProvider>().isReload;

    bool isUser = UserRepository().isUser;
    UserBox? user = userBox?.get('userProfile');
    String? fontFamily = user?.fontFamily ?? initFontFamily;
    String initialRoute = isUser ? 'home-page' : 'start-page';

    return MaterialApp(
      title: 'praise diary',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
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
