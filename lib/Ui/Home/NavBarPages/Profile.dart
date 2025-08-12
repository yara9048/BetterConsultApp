import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/Auth/logoutProvider.dart';
import '../../../main.dart';
import '../Components/InfoCard.dart';
import '../Components/ProfileItemRow.dart';
import '../Components/SectionHeader.dart';
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
          // React to logout success or error AFTER build:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (logoutProvider.isSuccess) {
              logoutProvider.reset();
              Navigator.pushReplacementNamed(context, '/login');
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

                  const Text(
                    'Profile',
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

                  const SectionHeader(label: 'Personal Information'),
                  const SizedBox(height: 8),
                  const InfoCard(
                    children: [
                      ProfileItemRow(icon: Icons.person, label: 'First Name'),
                      ProfileItemRow(icon: Icons.person_outline, label: 'Last Name'),
                      ProfileItemRow(icon: Icons.location_on, label: 'Location'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const SectionHeader(label: 'Contact Details'),
                  const SizedBox(height: 8),
                  const InfoCard(
                    children: [
                      ProfileItemRow(icon: Icons.email, label: 'Email Address'),
                      ProfileItemRow(icon: Icons.phone, label: 'Phone Number'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const SectionHeader(label: 'Preferences'),
                  const SizedBox(height: 8),
                  InfoCard(
                    children: [
                      StatefulBuilder(
                        builder: (context, setStateSB) {
                          return ProfileItemRow(
                            icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                            label: 'Themes',
                            trailingWidget: Padding(
                              padding: const EdgeInsets.only(left: 140.0),
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
                            label: 'Language',
                            trailingWidget: Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: SizedBox(
                                width: 120,
                                child: CompactDropdown(
                                  value: currentLanguage,
                                  items: [
                                    DropdownMenuItem(
                                      value: 'en',
                                      child: Text(
                                        "English",
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontFamily: 'NotoSerifGeorgian',
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'ar',
                                      child: Text(
                                        "Arabic",
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

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
