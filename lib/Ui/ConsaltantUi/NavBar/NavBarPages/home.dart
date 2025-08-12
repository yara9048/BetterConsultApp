import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../Home/Components/ChatHistoryCard.dart';
import '../../../Home/Components/SettingNotificationsWidget.dart';
import '../../../Home/Components/ThemeLanguagePopup.dart';
import '../../../Home/Pages/Notifications.dart';

class HomeCons extends StatefulWidget {
  const HomeCons({super.key});

  @override
  State<HomeCons> createState() => _HomeConsState();
}

class _HomeConsState extends State<HomeCons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
     body: Padding(
       padding: const EdgeInsets.only(left: 20, top: 62, right: 20),
       child: Column(
         children: [    // Header
           Row(
             children: [
               const SizedBox(width: 12),
               Expanded(
                 child: Text(
                   'Welcome, Consultant',
                   style: TextStyle(
                     fontSize: 30,
                     fontWeight: FontWeight.w600,
                     color: Theme.of(context).colorScheme.primary,
                     fontFamily: 'NotoSerifGeorgian',
                   ),
                 ),
               ),
               Row(
                 children: [
                   SettingNotificationsWidget(title: 'Notification', icon: Icons.notifications_none, onTap: () async {
                     Navigator.push(context, MaterialPageRoute(builder: (context) {return Notifications();}));
                   },
                   ),
                   SizedBox(width: 10),
                   SettingNotificationsWidget(title: 'Settings', icon: Icons.settings, onTap: () { _showThemeLanguageDialog(); },)
                 ],
               ),

             ],
           ),
           const SizedBox(height: 4),
           Text(
             'Let’s display some of the consultant that has been implemented ',
             style: TextStyle(
                 fontSize: 16,
                 color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                 fontFamily: 'NotoSerifGeorgian',
                 fontWeight: FontWeight.bold),
           ),
           const SizedBox(height: 20),
           Expanded(
             child: MediaQuery.removePadding(
               context: context,
               removeTop: true,
               child: ListView.separated(
                 itemCount: 5,
                 separatorBuilder: (_, __) => const SizedBox(height: 12),
                 itemBuilder: (context, index) {
                   return ChatHistoryCard(
                     name: 'Dr. Amira Khaled',
                     specializing: 'Nutritionist',
                     content: 'Here goes the content of the chat',
                     timestamp: 'Jul 30 • 3:14 PM',
                     onTap: () {
                       // Navigate to chat screen
                     },
                   );
                 },
               ),
             ),
           ),

         ],
       ),
     ),
    );
  }
  void _showThemeLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ThemeLanguageDialog(
          isDarkMode: MyApp.of(context).isDarkMode,
          currentLanguage: MyApp.of(context).locale.languageCode,
          onThemeChanged: (isDark) {
            MyApp.of(context).setTheme(isDark);
          },
          onLanguageChanged: (lang) {
            MyApp.of(context).setLocale(lang);
          },
        );
      },
    );
  }

}
