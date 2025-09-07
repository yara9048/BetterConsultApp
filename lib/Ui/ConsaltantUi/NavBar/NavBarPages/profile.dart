import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Models/Home/Consultant/ShowConsultantProfileModedl.dart';

import '../../../../Providers/Auth/logoutProvider.dart';
import '../../../../Providers/Home/Consultant/ConsultantEditProfile.dart';
import '../../../../Providers/Home/Consultant/ConsultantShowProfile.dart';
import '../../../../Providers/Home/User/NavBarProviders/DeleteProfileProvider.dart';
import '../../../../Providers/Home/User/NavBarProviders/EditProfile.dart';
import '../../../../Providers/Home/User/NavBarProviders/ViewProfileProvider.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../Auth/Login/pages/login.dart';
import '../../../Auth/Register/Compoenets/text.dart';
import '../../../Home/Components/InfoCard.dart';
import '../../../Home/Components/ProfileItemRow.dart';
import '../../../Home/Components/SectionHeader.dart';
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
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ViewProfileConsultantProvider>(context, listen: false)
          .fetchConsultantProfile();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode = MyApp.of(context).isDarkMode;
    currentLanguage = MyApp.of(context).locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer2<Logoutprovider, ViewProfileConsultantProvider>(
      builder: (context, logoutProvider, profileProvider, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (logoutProvider.isSuccess) {
            logoutProvider.reset();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Login()),
            );
          } else if (logoutProvider.errorMessage != null) {
            final msg = logoutProvider.errorMessage!;
            logoutProvider.reset();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: text(
                  label: msg,
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
                  alignment: isArabic()
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Notifications(),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  S.of(context).profile,
                  style: const TextStyle(
                    fontFamily: 'NotoSerifGeorgian',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: isArabic()
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: logoutProvider.isLoading
                      ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                      : IconButton(
                    onPressed: () => logoutProvider.logout(),
                    icon: Icon(
                      isArabic() ? Icons.login : Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Builder(
            builder: (context) {
              if (profileProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (profileProvider.errorMessage != null) {
                return Center(
                  child: text(
                    label: profileProvider.errorMessage!,
                    fontSize: 16,
                    color: theme.colorScheme.error,
                  ),
                );
              } else if (profileProvider.profile == null) {
                return Center(
                  child: text(
                    label: "nothing to show",
                    fontSize: 25,
                    color: theme.colorScheme.primary,
                  ),
                );
              } else {
                final profile = profileProvider.profile!;
                return SingleChildScrollView(
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
                                color: theme.colorScheme.primary.withOpacity(0.1),
                                child: Image.network(
                                  profile.photo?["file_url"] ?? '',
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${profile.firstName} ${profile.lastName}",
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
                      InfoCard(
                        children: [
                          ProfileItemRow(
                            icon: Icons.person,
                            label: profile.firstName ?? '',

                          ),
                          ProfileItemRow(
                            icon: Icons.person_outline,
                            label: profile.lastName ?? '',
                          ),
                          ProfileItemRow(
                            icon: Icons.location_on,
                            label: profile.location ?? '',

                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(label: S.of(context).contactDetails),
                      const SizedBox(height: 8),
                      InfoCard(
                        children: [
                          ProfileItemRow(
                            icon: Icons.email,
                            label: profile.email ?? '',
                          ),
                          ProfileItemRow(
                            icon: Icons.phone,
                            label: 'Phone Number',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(label: S.of(context).professionalInformation),
                      const SizedBox(height: 8),
                      InfoCard(
                        children: [
                          ProfileItemRow(
                            icon: Icons.work,
                            label: profile.domainName ?? '',
                          ),
                          ProfileItemRow(
                            icon: Icons.timeline,
                            label: profile.yearsExperience.toString(),
                          ),
                          ProfileItemRow(
                            icon: Icons.business,
                            label: profile.location ?? '',
                          ),
                          ProfileItemRow(
                            icon: Icons.info_outline,
                            label: profile.description ?? '' ,
                            trailingWidget: const Icon(Icons.edit),
                            onEdit: () {
                              showEditPopup(
                                context: context,
                                fieldType: "bio",
                                title: "Edit Bio",
                                initialValue: profile.description ?? '' ,
                              );
                            },
                          ),
                          ProfileItemRow(
                            icon: Icons.language,
                            label: profile.yearsExperience.toString(),
                          ),
                          ProfileItemRow(
                            icon: Icons.attach_money,
                            label: profile.cost.toString(),
                            trailingWidget: const Icon(Icons.edit),
                            onEdit: () {
                              showEditPopup(
                                context: context,
                                fieldType: "cost",
                                title: "Edit cost",
                                initialValue: profile.cost.toString(),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildDeleteAccountButton(context),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildDeleteAccountButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
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
                horizontal: 16,
                vertical: 24,
              ),
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
                    Icon(Icons.warning,
                        size: 60,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 16),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSerifGeorgian',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Are you sure you want to delete your personal account forever?",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NotoSerifGeorgian',
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              S.of(context).cancel,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'NotoSerifGeorgian',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
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
                                  MaterialPageRoute(
                                    builder: (_) => Login(),
                                  ),
                                      (route) => false,
                                );
                              } else if (deleteProvider.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: text(
                                      label: deleteProvider.errorMessage!,
                                      fontSize: 14,
                                      color:
                                      Theme.of(context).colorScheme.onSurface,
                                    ),
                                    backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                                );
                              }
                            },
                            child: deleteProvider.isLoading
                                ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Text(
                              S.of(context).confirm,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
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
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
Future<void> showEditPopup({
  required BuildContext context,
  required String fieldType,
  required String title,
  required String initialValue,
}) async {
  final TextEditingController controller = TextEditingController(text: initialValue);
  TextInputType keyboardType;

  switch (fieldType.toLowerCase()) {
    case "location":
    case "bio":
      keyboardType = TextInputType.name;
      break;
    case "cost":
      keyboardType = TextInputType.number;
      break;
    default:
      keyboardType = TextInputType.text;
  }

  await showDialog(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        backgroundColor: theme.colorScheme.onSurface,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer2<EditConsultantProfileProvider, ViewProfileConsultantProvider>(
            builder: (context, editProvider, viewProvider, _) {
              return StatefulBuilder(
                builder: (context, setStateSB) {
                  final profile = viewProvider.profile;
                  if (profile == null) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          "Profile not loaded yet",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontFamily: 'NotoSerifGeorgian',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          fontFamily: 'NotoSerifGeorgian',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller,
                        keyboardType: keyboardType,
                        style: TextStyle(
                          color: theme.colorScheme.surface.withOpacity(0.8),
                          fontFamily: 'NotoSerifGeorgian',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter $fieldType",
                          hintStyle: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 16,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Cancel button
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.colorScheme.primary),
                            ),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                S.of(context).cancel,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.colorScheme.primary,
                                  fontFamily: 'NotoSerifGeorgian',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Submit button
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: editProvider.isLoading
                                  ? null
                                  : () async {
                                final newValue = controller.text.trim();
                                final first = fieldType.toLowerCase() == "firstName"
                                    ? newValue
                                    : profile.firstName;
                                final last = fieldType.toLowerCase() == "lastName"
                                    ? newValue
                                    : profile.lastName;
                                final location = fieldType.toLowerCase() == "location"
                                    ? newValue
                                    : profile.location;
                                final email = fieldType.toLowerCase() == "email"
                                    ? newValue
                                    : profile.email;
                                final bio = fieldType.toLowerCase() == "bio"
                                    ? newValue
                                    : profile.description;
                                final cost = fieldType.toLowerCase() == "cost"
                                    ? (double.tryParse(newValue)?.toInt() ?? profile.cost)
                                    : profile.cost;
                                await editProvider.editConsultantProfile(
                                  cost: cost,
                                  firstName: first ?? '',
                                  lastName: last ?? '',
                                  location: location ?? '',
                                  email: email ?? '',
                                  description: bio ?? '',
                                  title: title ?? '',
                                );
                                setStateSB(() {});
                                if (editProvider.isVerified) {
                                  await viewProvider.fetchConsultantProfile();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: text(
                                        label: "Profile updated successfully",
                                        fontSize: 14,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                    ),
                                  );
                                } else if (editProvider.errorMessage != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: text(
                                        label: editProvider.errorMessage!,
                                        fontSize: 14,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                    ),
                                  );
                                }
                              },
                              child: editProvider!.isLoading
                                  ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : Text(
                                "Submit",
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontFamily: 'NotoSerifGeorgian',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}

