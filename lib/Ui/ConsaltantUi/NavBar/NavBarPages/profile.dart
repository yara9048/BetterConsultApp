import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/Auth/logoutProvider.dart';
import '../../../../Providers/Home/User/NavBarProviders/DeleteProfileProvider.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../Auth/Login/pages/login.dart';
import '../../../Auth/Register/Compoenets/text.dart';
import '../../../Home/Components/InfoCard.dart';
import '../../../Home/Components/ProfileItemRow.dart';
import '../../../Home/Components/SectionHeader.dart';
import '../../../Home/Components/_buildCompactDropdown.dart';
import '../../../Home/Pages/Notifications.dart';


class ProfileCons extends StatefulWidget {
  const ProfileCons({super.key});

  @override
  State<ProfileCons> createState() => _ProfileConsState();
}

class _ProfileConsState extends State<ProfileCons> {
  bool isDarkMode = false;
  String currentLanguage = 'en';

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
                SnackBar(
                  content: text(
                    label:msg,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
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
                    alignment: isArabic() ? Alignment.centerRight : Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notifications()),
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
                    alignment: isArabic() ? Alignment.centerLeft : Alignment.centerRight,
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
                        isArabic()?
                        Icons.login:
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
                              color:
                              theme.colorScheme.primary.withOpacity(0.1),
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

                  // Personal Info
                   SectionHeader(label: S.of(context).personalInformation),
                  const SizedBox(height: 8),
                  const InfoCard(
                    children: [
                      ProfileItemRow(icon: Icons.person, label: 'First Name'),
                      ProfileItemRow(
                          icon: Icons.person_outline, label: 'Last Name'),
                      ProfileItemRow(
                          icon: Icons.location_on, label: 'Location'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Contact Details
                   SectionHeader(label: S.of(context).contactDetails),
                  const SizedBox(height: 8),
                  const InfoCard(
                    children: [
                      ProfileItemRow(icon: Icons.email, label: 'Email Address'),
                      ProfileItemRow(icon: Icons.phone, label: 'Phone Number'),
                    ],
                  ),

                  const SizedBox(height: 24),

                   SectionHeader(label: S.of(context).professionalInformation),
                  const SizedBox(height: 8),
                  const InfoCard(
                    children: [
                      ProfileItemRow(
                          icon: Icons.work, label: 'Field Specialization'),
                      ProfileItemRow(
                          icon: Icons.timeline, label: 'Years of Experience'),
                      ProfileItemRow(
                          icon: Icons.business, label: 'Business Location'),
                      ProfileItemRow(icon: Icons.info_outline, label: 'Bio'),
                      ProfileItemRow(
                          icon: Icons.language, label: 'Spoken Languages'),
                      ProfileItemRow(
                          icon: Icons.attach_money, label: 'Cost'),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _showDeleteConfirmation(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_forever,
                                  color: Theme.of(context).colorScheme.onSurface),
                              const SizedBox(width: 10),
                              Text(
                                "delete account",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NotoSerifGeorgian',
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<DeleteProfile>(
          builder: (context, deleteProvider, child) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 12,
              insetPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery
                      .of(context)
                      .size
                      .width * 0.85,
                ),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning, size: 60, color: Theme
                        .of(context)
                        .colorScheme
                        .primary),
                    const SizedBox(height: 16),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSerifGeorgian',
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Are you sure you want to delete your personal account forever?",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NotoSerifGeorgian',
                        fontWeight: FontWeight.w500,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              S
                                  .of(context)
                                  .cancel,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                fontFamily: 'NotoSerifGeorgian',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: deleteProvider.isLoading
                                ? null
                                : () async {
                              await deleteProvider.deleteAccount();
                              if (deleteProvider.isVerified) {
                                Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => Login()),
                                      (route) => false,
                                );
                              } else if (deleteProvider.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: text(
                                      label: deleteProvider.errorMessage!,
                                      fontSize: 14,
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    backgroundColor: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                );
                              }
                            },
                            child: deleteProvider.isLoading
                                ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                                : Text(
                              S
                                  .of(context)
                                  .confirm,
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurface,
                                fontFamily: 'NotoSerifGeorgian',
                                fontSize: 16,
                              ),
                            ),
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
      },
    );
  }}
    bool isArabic() {
      return Intl.getCurrentLocale() == 'ar';
    }
