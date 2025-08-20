import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/Models/Home/User/NavBar/ViewProfileModel.dart';
import 'package:untitled6/Providers/Auth/LoginProvider.dart';
import 'package:untitled6/Providers/Auth/NewPasswordProvider.dart';
import 'package:untitled6/Providers/Home/User/NavBarProviders/AddToFavoriteProvider.dart';
import 'package:untitled6/Providers/Home/User/NavBarProviders/DeleteFromFavoriiteProvider.dart';
import 'package:untitled6/Providers/Home/User/NavBarProviders/ViewProfileProvider.dart';

import 'package:untitled6/Themes/darkTheme.dart';
import 'package:untitled6/Themes/lightTheme.dart';
import 'DIO/DioHelper.dart';
import 'Models/Home/User/NavBar/DeleteProfile.dart';
import 'Providers/Auth/SendOtpProvider.dart';
import 'Providers/Auth/VerifyEmailProvider.dart';
import 'Providers/Home/User/NavBarProviders/GetAlFavoriteProvider.dart';
import 'Providers/Home/User/NavBarProviders/GetDomainsProvider.dart';
import 'Providers/Home/User/NavBarProviders/GetSubDomainsProvider.dart';
import 'Providers/Home/User/NavBarProviders/SearchProvider.dart';
import 'Providers/Home/User/Others/AllConultandProvider.dart';
import 'Providers/Home/User/Others/ConsultantDetailsProvider.dart';
import 'Providers/Home/User/Others/SendApplicationProvider.dart';
import 'Ui/Auth/Login/pages/login.dart';
import 'Ui/Auth/Register/Pages/IsConsaltant.dart';
import 'Ui/Auth/Register/Pages/register.dart';
import 'Ui/Auth/onBoarding/pages/onBoarding.dart';
import 'Ui/ConsaltantUi/NavBar/NavBarPages/addConsutation.dart';
import 'Ui/ConsaltantUi/NavBar/Pages/consultNavBar.dart';
import 'Ui/Home/Pages/NavBar.dart';
import 'generated/l10n.dart';
import 'package:provider/provider.dart';
import 'Providers/Auth/logoutProvider.dart';


void main() {
  DioHelper.init();

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



          ],
          child: MyApp()));
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
  }

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
      home:  onboarding(),
    );
  }
}
