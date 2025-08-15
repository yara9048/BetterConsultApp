import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Providers/Auth/logoutProvider.dart';
import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../Auth/Login/pages/login.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../../Auth/Register/Pages/IsConsaltant.dart';
import '../Components/InfoCard.dart';
import '../Components/ProfileItemRow.dart';
import '../Components/SectionHeader.dart';
import '../Components/ThemeLanguagePopup.dart';
import '../Components/_buildCompactDropdown.dart';
import '../Pages/Notifications.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool isDarkMode;
  late String currentLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode = MyApp.of(context).isDarkMode;
    currentLanguage = MyApp.of(context).locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => Logoutprovider(),
      child: Consumer<Logoutprovider>(
        builder: (context, logoutProvider, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (logoutProvider.isSuccess) {
              logoutProvider.reset();
              Navigator.push(context, MaterialPageRoute(builder: (context){return Login();}));
            } else if (logoutProvider.errorMessage != null) {
              final msg = logoutProvider.errorMessage!;
              logoutProvider.reset();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg)),
              );
            }
          });

          return Scaffold(
            backgroundColor: const Color(0xfff5f7fa),
            appBar: AppBar(
              backgroundColor: theme.colorScheme.primary,
              automaticallyImplyLeading: false,
              title: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Notifications()),
                        );
                      },
                    ),
                  ),

                   Text(
                    S.of(context).profile,
                    style: TextStyle(
                      fontFamily: 'NotoSerifGeorgian',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: logoutProvider.isLoading
                        ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.onSurface,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                        : IconButton(
                      onPressed: () => logoutProvider.logout(),
                      icon: Icon(
                        Icons.logout,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 125,
                            height: 125,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 90,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Name',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                   SectionHeader(label: S.of(context).personalInformation),
                  const SizedBox(height: 8),
                  const InfoCard(
                    children: [
                      ProfileItemRow(icon: Icons.person, label: 'First Name'),
                      ProfileItemRow(icon: Icons.person_outline, label: 'Last Name'),
                      ProfileItemRow(icon: Icons.location_on, label: 'Location'),
                    ],
                  ),

                  const SizedBox(height: 24),

                   SectionHeader(label: S.of(context).contactDetails),
                  const SizedBox(height: 8),
                  const InfoCard(
                    children: [
                      ProfileItemRow(icon: Icons.email, label: 'Email Address'),
                      ProfileItemRow(icon: Icons.phone, label: 'Phone Number'),
                    ],
                  ),

                  const SizedBox(height: 24),

                   SectionHeader(label: S.of(context).preferences),
                  const SizedBox(height: 8),
                  InfoCard(
                    children: [
                      StatefulBuilder(
                        builder: (context, setStateSB) {
                          return ProfileItemRow(
                            icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                            label: S.of(context).theme,
                            trailingWidget: Padding(
                              padding: EdgeInsets.only(left: isArabic()? 0 :140.0,right: isArabic()?140:0),
                              child: Switch.adaptive(
                                value: isDarkMode,
                                onChanged: (value) {
                                  setStateSB(() {
                                    isDarkMode = value;
                                  });
                                  MyApp.of(context).setTheme(value);
                                },
                                activeColor: theme.colorScheme.primary,
                                activeTrackColor: theme.colorScheme.primary.withOpacity(0.5),
                                inactiveThumbColor: theme.colorScheme.primary,
                                inactiveTrackColor: theme.colorScheme.primary.withOpacity(0.3),
                              ),
                            ),
                          );
                        },
                      ),

                      StatefulBuilder(
                        builder: (context, setStateSB) {
                          return ProfileItemRow(
                            icon: Icons.language,
                            label: S.of(context).language,
                            trailingWidget: Padding(
                              padding:  EdgeInsets.only(left:isArabic()?0: 60.0,right: isArabic()?90:0),
                              child: SizedBox(
                                width: 120,
                                child: CompactDropdown(
                                  value: currentLanguage,
                                  items: [
                                    DropdownMenuItem(
                                      value: 'en',
                                      child: Text(
                                        S.of(context).english,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontFamily: 'NotoSerifGeorgian',
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'ar',
                                      child: Text(
                                        S.of(context).arabic,
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontFamily: 'NotoSerifGeorgian',
                                        ),
                                      ),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() => currentLanguage = val);
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.secondary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          _Confirmation();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Center(
                            child: text(
                              label:S.of(context).switchToConsultant,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void _Confirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 12,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).confirmation,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'NotoSerifGeorgian',
                  ),
                ),
                const SizedBox(height: 20),
            Text(
              S.of(context).confirmation1 + " " + S.of(context).confirmation2 + " " + S.of(context).confirmation3 + " " + S.of(context).confirmation4,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'NotoSerifGeorgian',
              ),),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Theme.of(context).colorScheme.primary),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          textStyle: const TextStyle(
                            fontFamily: 'NotoSerifGeorgian',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child:  Text(S.of(context).cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(
                            fontFamily: 'NotoSerifGeorgian',
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){return Isconsaltant();}));
                        },
                        child: Text(S.of(context).confirm),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },

    );
  }
  bool isArabic () {
    return Intl.getCurrentLocale() == 'ar';
  }


}
