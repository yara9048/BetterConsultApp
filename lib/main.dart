import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:untitled6/firebase_options.dart';
import 'DIO/DioHelper.dart';
import 'Providers/Auth/LoginProvider.dart';
import 'Providers/Auth/NewPasswordProvider.dart';
import 'Providers/Auth/SendOtpProvider.dart';
import 'Providers/Auth/VerifyEmailProvider.dart';
import 'Providers/Auth/logoutProvider.dart';
import 'Providers/Home/User/NavBarProviders/AddToFavoriteProvider.dart';
import 'Providers/Home/User/NavBarProviders/ChatHistoryProvider.dart';
import 'Providers/Home/User/NavBarProviders/DeleteChatProvider.dart';
import 'Providers/Home/User/NavBarProviders/DeleteFromFavoriiteProvider.dart';
import 'Providers/Home/User/NavBarProviders/ViewProfileProvider.dart';
import 'Providers/Home/User/NavBarProviders/GetAlFavoriteProvider.dart';
import 'Providers/Home/User/NavBarProviders/GetDomainsProvider.dart';
import 'Providers/Home/User/NavBarProviders/SearchProvider.dart';
import 'Providers/Home/User/NavBarProviders/DeleteProfileProvider.dart';
import 'Providers/Home/User/NavBarProviders/EditProfile.dart';
import 'Providers/Home/User/Others/ChatHistoryContentProvider.dart';
import 'Providers/Home/User/Others/ChatProvider.dart';
import 'Providers/Home/User/Others/ConsultantReviewProvider.dart';
import 'Providers/Home/User/Others/GetSubDomainsProvider.dart';
import 'Providers/Home/User/Others/AllConultandProvider.dart';
import 'Providers/Home/User/Others/ConsultantDetailsProvider.dart';
import 'Providers/Home/User/Others/SendApplicationProvider.dart';
import 'Providers/Home/Consultant/CheckQuaityProvider.dart';

import 'Ui/Auth/Login/pages/login.dart';
import 'Themes/darkTheme.dart';
import 'Themes/lightTheme.dart';
import 'generated/l10n.dart';

/// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("----------------------");
  print('Handling a background message: ${message.messageId}');
  print("----------------------");

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  DioHelper.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => Logoutprovider()),
        ChangeNotifierProvider(create: (_) => VerifyEmailProvider()),
        ChangeNotifierProvider(create: (_) => SendOTPProvider()),
        ChangeNotifierProvider(create: (_) => NewPasswordProvider()),
        ChangeNotifierProvider(create: (_) => GetDomainsProvider()),
        ChangeNotifierProvider(create: (_) => GetSubDomainsProvider()),
        ChangeNotifierProvider(create: (_) => SendApplicationProvider()),
        ChangeNotifierProvider(create: (_) => AllConsultantProvider()),
        ChangeNotifierProvider(create: (_) => DeleteFromFavoriteProvider()),
        ChangeNotifierProvider(create: (_) => AddToFavoriteProvider()),
        ChangeNotifierProvider(create: (_) => GetFavorite()),
        ChangeNotifierProvider(create: (_) => ConsultantDetailsProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ViewProfileProvider()),
        ChangeNotifierProvider(create: (_) => DeleteProfile()),
        ChangeNotifierProvider(create: (_) => EditProfile()),
        ChangeNotifierProvider(create: (_) => ConsultantReviewProvider()),
        ChangeNotifierProvider(create: (_) => CheckQuaityProvider()),
        ChangeNotifierProvider(create: (_) => ChatHistoryProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => DeleteChatProvider()),
        ChangeNotifierProvider(create: (_) => ChatHistoryContentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static final GlobalKey<_MyAppState> globalKey = GlobalKey<_MyAppState>();
  MyApp() : super(key: globalKey);

  @override
  _MyAppState createState() => _MyAppState();
  static _MyAppState of(BuildContext context) => globalKey.currentState!;
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  bool get isDarkMode => _isDarkMode;
  Locale get locale => _locale;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _setupFirebaseMessaging();
  }

  /// Load saved theme & language preferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    final langCode = prefs.getString('languageCode') ?? 'en';
    setState(() {
      _isDarkMode = isDark;
      _locale = Locale(langCode);
    });
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  void setTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
    _saveTheme(isDark);
  }

  void setLocale(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
    _saveLanguage(languageCode);
  }

  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print("----------------------");
    print('User granted permission: ${settings.authorizationStatus}');
    print("----------------------");
    String? token = await messaging.getToken();
    print("----------------------");
    print('Device Token: $token');
    print("----------------------");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("----------------------");
      print('Foreground message received: ${message.notification?.title}');
      print("----------------------");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("----------------------");
      print('Notification clicked: ${message.data}');
      print("----------------------");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? darkMode : lightMode,
      locale: _locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Login(),
    );
  }
}
